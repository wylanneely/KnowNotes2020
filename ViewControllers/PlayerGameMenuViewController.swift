//
//  PlayerGameMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/18/20.
//

import GameKit

class PlayerGameMenuViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, InstrumentCollectionCellDelegate{

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        setupCollectionView()
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 400)
        
        collectionView?.setCollectionViewLayout(layout, animated: false)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
    //MARK: Unlock Instruments
    
    var isAcousticGuitarUnlocked: Bool = false
    var isViolinUnlocked: Bool = false
    
    typealias SuccessHandler = (Bool) -> Void
    
    let unlockAcousticGuitarAlert: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    var unlockAcousticAlertController: UIAlertController {
        let alert = UIAlertController(title: "Acoustic Locked", message: "Score 20 or more notes with the Grand Piano to unlock the Acoustic Guitar.", preferredStyle: .alert)
        alert.addAction(unlockAcousticGuitarAlert)
        return alert
    }
    var unlockViolinAlertController: UIAlertController {
        let alert = UIAlertController(title: "Violin Locked", message: "Score 20 or more chords with the Acoustic Guitar to unlock the Violin.", preferredStyle: .alert)
        alert.addAction(unlockAcousticGuitarAlert)
        return alert
    }

    //MARK: Outlets & Actions
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var localPlayerProfilePhoto: UIImageView!
    
    
    @IBAction func showGameCenterDashboard(_ sender: Any) {
        GameCenterManager.manager.presentGameCenterDashboard()
    }
    //MARK: Delegate
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
//MARK: Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
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

        default:
           return cell
        }
    }
    
    //MARK: Delegate
    
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
                performSegue(withIdentifier: "", sender: self )
            } else {
                self.present(unlockViolinAlertController, animated: true) {
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
           switch segue.identifier {
           case "toAcousticNotes" :
               LessonSession.manager.setAcousticLesson()
               vc.instrumentImage = UIImage(named: "acoustic_Guitar")
               vc.instrumentType = InstrumentType.acousticGuitar
           case "toGrandPianoNotes" :
               LessonSession.manager.setGrandPianoLesson()
               vc.instrumentImage = UIImage(named: "grand_Piano")
               vc.instrumentType = InstrumentType.grandPiano
           default:
               return } }
   }
}
