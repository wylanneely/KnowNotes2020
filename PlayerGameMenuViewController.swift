//
//  PlayerGameMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/18/20.
//

import GameKit



protocol ViewModelIAPDelegate {
    func toggleOverlay(shouldShow: Bool)
    func willStartLongProcess()
    func didFinishLongProcess()
    func showIAPRelatedError(_ error: Error)
    func shouldUpdateUI()
    func didFinishRestoringPurchasesWithZeroProducts()
    func didFinishRestoringPurchasedProducts()
}

class PlayerGameMenuViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, InstrumentCollectionCellDelegate{
    
    
    //MARK:IAP

    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isOnline == true {
            //MARK:In APP PUrchase
          
            
            
            
            GameCenterManager.manager.viewController = self
            localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        } else {
            gameCenterButton.setTitle("Offline Notes", for: .normal)
            gameCenterButton.isEnabled = false
            gameCenterImage.isHidden = true
        }
        setupCollectionView()
        setUpProfilePhotoGestures()
    }
    
    //MARK: Set Up
    func setUpProfilePhotoGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.photoTapped(_:)))
        localPlayerProfilePhoto.isUserInteractionEnabled = true
        localPlayerProfilePhoto.addGestureRecognizer(tapGesture)
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 500)
        collectionView?.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: Unlocked Instruments
    
    var isAcousticGuitarUnlocked: Bool {
        return GameCenterManager.manager.leaderboardsManager.isAcousticGuitarUnlocked
    }
    var isViolinUnlocked: Bool {
        return GameCenterManager.manager.leaderboardsManager.isViolinUnlocked
    }
    var isSaxophoneUnlocked: Bool {
        return GameCenterManager.manager.leaderboardsManager.isSaxaphoneUnlocked
    }
    
    //MARK: Properties
    
    var isOnline: Bool {
        return GameCenterManager.manager.isOnline
    }
    
    typealias SuccessHandler = (Bool) -> Void
    
    let OkAlertAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    var unlockAcousticAlertController: UIAlertController {
        let alert = UIAlertController(title: "Acoustic Locked", message: "Score 20 with the Grand Piano to unlock the Acoustic Guitar.", preferredStyle: .alert)
        alert.addAction(OkAlertAction)
        return alert
    }
    var unlockViolinAlertController: UIAlertController {
        let alert = UIAlertController(title: "Violin Locked", message: "Score 20 chords with the Acoustic Guitar to unlock the Violin.", preferredStyle: .alert)
        alert.addAction(OkAlertAction)
        return alert
    }
    var unlockSaxAlertController: UIAlertController {
        let alert = UIAlertController(title: "Saxophone Locked", message: "Score 20 with the Violin to unlock the Saxophone.", preferredStyle: .alert)
        alert.addAction(OkAlertAction)
        return alert
    }
    var finishedGameAlert: UIAlertController {
        let alert = UIAlertController(title: "Exit", message: "Return to main menu", preferredStyle: .alert)
        let action = UIAlertAction(title: "Leave", style: .destructive) { (_) in
            self.performSegue(withIdentifier: "toLaunch", sender: self)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
        }
        alert.addAction(action)
        alert.addAction(action2)
        return alert
    }
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var localPlayerProfilePhoto: UIImageView!
    @IBOutlet weak var gameCenterImage: UIImageView!
    @IBOutlet weak var gameCenterButton: UIButton!

    @IBAction func showGameCenterDashboard(_ sender: Any) {
            GameCenterManager.manager.presentGameCenterDashboard()
        }
    
    @objc func photoTapped(_ sender:AnyObject){
            self.present(finishedGameAlert, animated: true, completion: nil)
        }
    
//MARK: Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstrumentCCell", for: indexPath) as? InstrumentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        switch indexPath.item {
        case 0:
            cell.setUp(type: .grandPiano, isUnlocked: true)
            return cell
        case 1:
            cell.setUp(type: .acousticGuitar, isUnlocked: isAcousticGuitarUnlocked)
            return cell
        case 2:
            cell.setUp(type: .violin, isUnlocked: isViolinUnlocked)
            return cell
        case 3:
            cell.setUp(type: .saxaphone, isUnlocked: isSaxophoneUnlocked )
            return cell
        default:
           return cell
        }
    }
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func instrumentCellButtonTapped(type: InstrumentType) {
        switch type {
        case .grandPiano:
            performSegue(withIdentifier: "toGrandPianoNotes", sender: self)
        case .acousticGuitar:
            if isAcousticGuitarUnlocked {
                performSegue(withIdentifier: "toAcousticNotes", sender: self)
            } else {
                self.present(unlockAcousticAlertController, animated: true) {
                }
            }
        case .violin:
            if isViolinUnlocked {
                performSegue(withIdentifier: "toViolinNotes", sender: self )
            } else {
                self.present(unlockViolinAlertController, animated: true) {
                }
            }
        case .saxaphone:
            if isSaxophoneUnlocked {
                performSegue(withIdentifier: "toSaxNotes", sender: self )
            } else {
                self.present(unlockSaxAlertController, animated: true) {
                }
            }
        }
    }
    
    //MARK: Navigation
   
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       if identifier == "toAcousticNotes" {
           if isAcousticGuitarUnlocked { return true }
           else { return false } }
       return true
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let vc = segue.destination as? KnownPlayerInstrumentNotesTableViewController {
        Session.manager.hasHalfNotes = false
           switch segue.identifier {
           case "toAcousticNotes" :
               Session.manager.setAcousticSession()
               vc.instrumentImage = UIImage(named: "acoustic_Guitar")
               vc.instrumentType = InstrumentType.acousticGuitar
           case "toGrandPianoNotes" :
               Session.manager.setGrandPianoSession()
               vc.instrumentImage = UIImage(named: "grand_Piano")
               vc.instrumentType = InstrumentType.grandPiano
           case "toViolinNotes" :
            Session.manager.setViolinSession()
            vc.instrumentImage = UIImage(named: "violin")
            vc.instrumentType = InstrumentType.violin
            
        case "toSaxNotes" :
         Session.manager.setSaxophoneSession()
         vc.instrumentImage = UIImage(named: "saxophone")
            vc.instrumentType = InstrumentType.saxaphone
           default:
               return } }
   }
}
