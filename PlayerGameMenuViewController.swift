//
//  PlayerGameMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/18/20.
//

import GameKit

class PlayerGameMenuViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate {
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        setupCollectionView()
    }
    
    let cellScale: CGFloat = 0.06
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 250, height: 400)

            collectionView?.setCollectionViewLayout(layout, animated: false)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    @IBAction func gameCenterTapped(_ sender: Any) {
        collectionView.reloadData()
    }
    
    
    //MARK: Unlock Instruments
    
    var isAcousticGuitarUnlocked: Bool = false
    var isViolinUnlocked: Bool = false
    
    typealias SuccessHandler = (Bool) -> Void
    
    var unlockAlertController: UIAlertController {
        let alert = UIAlertController(title: "Instrument Locked", message: "Unlock the Acoustic Guitar by scoring 20 or more points with the Grand Piano.", preferredStyle: .alert)
        alert.addAction(unlockAcousticGuitarAlert)
        return alert
    }
    
    let unlockAcousticGuitarAlert: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
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
    
    
}
