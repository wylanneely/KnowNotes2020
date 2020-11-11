//
//  LocalPlayerMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit

class LocalPlayerMenuViewController: UIViewController {
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        setInstrumentStatusView()
    }
    
    func setInstrumentStatusView(){
        grandPianoStatusView.layer.cornerRadius = 10
        grandPianoStatusView.layer.borderWidth = 2
        grandPianoStatusView.layer.borderColor = UIColor.mediumTurqouise.cgColor
        acousticGuitarStatusView.layer.cornerRadius = 10
        acousticGuitarStatusView.layer.borderWidth = 2
        //Check set which instruments are unlocked
        if isAcousticGuitarUnlocked {
            DispatchQueue.main.async { //unlocked
                self.acousticGuitarStatusView.layer.backgroundColor = UIColor.starCommandBlue.cgColor
                self.acousticGuitarStatusView.layer.borderColor = UIColor.mediumTurqouise.cgColor
                self.buttonAcousticGuitar.setTitleColor(UIColor.mediumTurqouise, for: .normal) } }
        else {
            DispatchQueue.main.async { //locked
                self.acousticGuitarStatusView.layer.backgroundColor = UIColor.gray.cgColor
                self.acousticGuitarStatusView.layer.borderColor = UIColor.coralRed.cgColor
                self.buttonAcousticGuitar.setTitleColor(UIColor.lightGray, for: .normal)
                self.buttonAcousticGuitar.setTitleShadowColor(UIColor.clear, for: .normal) } }
    }
    
    //MARK: Unlock Instruments
    
    var isAcousticGuitarUnlocked: Bool {
          //  return false
           return GameCenterManager.manager.achievementsManager.isAcousticGuitarUnlocked
       }
    
    var unlockAlertController: UIAlertController {
        let alert = UIAlertController(title: "Instrument Locked", message: "Unlock the Acoustic Guitar by scoring 20 or more points with the Grand Piano.", preferredStyle: .alert)
        alert.addAction(unlockAcousticGuitarAlert)
        return alert
    }
    
    let unlockAcousticGuitarAlert: UIAlertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var buttonAcousticGuitar: UIButton!
    @IBOutlet weak var acousticGuitarStatusView: UIView!
    @IBOutlet weak var grandPianoStatusView: UIView!
    @IBOutlet weak var localPlayerProfilePhoto: UIImageView!
    
    @IBAction func showGameCenterDashboard(_ sender: Any) {
        GameCenterManager.manager.presentGameCenterDashboard()
    }
    @IBAction func AcousticGuitarButtonTapped(_ sender: Any) {
        if isAcousticGuitarUnlocked { return } else { self.present(unlockAlertController, animated: true, completion: nil) }
    }
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
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

//For the circle cropped image
extension UIImage {
    var isPortrait:  Bool    { size.height > size.width }
    var isLandscape: Bool    { size.width > size.height }
    var breadth:     CGFloat { min(size.width, size.height) }
    var breadthSize: CGSize  { .init(width: breadth, height: breadth) }
    var breadthRect: CGRect  { .init(origin: .zero, size: breadthSize) }
    var circleMasked: UIImage? {
        guard let cgImage = cgImage?
                .cropping(to: .init(origin: .init(x: isLandscape ? ((size.width-size.height)/2).rounded(.down) : 0,
                                                  y: isPortrait  ? ((size.height-size.width)/2).rounded(.down) : 0),
                                    size: breadthSize)) else { return nil }
        let format = imageRendererFormat
        format.opaque = false
        return UIGraphicsImageRenderer(size: breadthSize, format: format).image { _ in
            UIBezierPath(ovalIn: breadthRect).addClip()
            UIImage(cgImage: cgImage, scale: format.scale, orientation: imageOrientation)
                .draw(in: .init(origin: .zero, size: breadthSize))
        }
    }
    
}
