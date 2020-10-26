//
//  LocalPlayerMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit

class LocalPlayerMenuViewController: UIViewController{
    
   //MARK: Unlocked Instruments
    
    var isAcousticGuitarUnlocked: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        setInstrumentStatusView()
    }
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var acousticGuitarStatusView: UIView!
    @IBOutlet weak var grandPianoStatusView: UIView!
    
    
    @IBOutlet weak var localPlayerProfilePhoto: UIImageView!
    
    @IBAction func showGameCenterDashboard(_ sender: Any) {
        GameCenterManager.manager.presentGameCenterDashboard()
    }
    @IBAction func AcousticGuitarButtonTapped(_ sender: Any) {
        if let isAcousticGuitarUnlocked = isAcousticGuitarUnlocked {
            if isAcousticGuitarUnlocked {
                
            } else {
                
            }
        }
    }
    
    
    
    //MARK: Set Up
    
    func setInstrumentStatusView(){
        acousticGuitarStatusView.layer.cornerRadius = 10
        grandPianoStatusView.layer.cornerRadius = 10
    }
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
           self.dismiss(animated: true, completion: nil)
       }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toAcousticNotes" {
            if let isAcousticGuitarUnlocked = isAcousticGuitarUnlocked {
                if isAcousticGuitarUnlocked {
                    return true
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? KnownPlayerInstrumentNotesTableViewController {
            switch segue.identifier {
            case "toAcousticNotes" : vc.instrumentImage = UIImage(named: "acoustic_Guitar")
            case "toGrandPianoNotes" : vc.instrumentImage = UIImage(named: "grand_Piano")
            default:
                return
            }
        }
        
    }
    
    
    
    

}

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
