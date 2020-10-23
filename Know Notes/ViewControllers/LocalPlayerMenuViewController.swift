//
//  LocalPlayerMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit

class LocalPlayerMenuViewController: UIViewController{
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        //displayGKAccessPoint()
        localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        setInstrumentStatusView()
    }
    
    func displayGKAccessPoint(){
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.isActive = true
    }
 
    //MARK: Outlets & Actions
    
    @IBOutlet weak var acousticGuitarStatusView: UIView!
    @IBOutlet weak var grandPianoStatusView: UIView!
    
    
    @IBOutlet weak var localPlayerProfilePhoto: UIImageView!
    
    @IBAction func showGameCenterDashboard(_ sender: Any) {
        GameCenterManager.manager.presentGameCenterDashboard()
    }
    
    //MARK: Set Up
    
    func setInstrumentStatusView(){
        acousticGuitarStatusView.layer.cornerRadius = 10
        grandPianoStatusView.layer.cornerRadius = 10
    }
//    
//    func setImageCircle() {
//        var localPlayerCircularPhoto = localPlayerProfilePhoto.image?.circleMasked
//        localPlayerProfilePhoto.layer
//    }
//    
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
           self.dismiss(animated: true, completion: nil)
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
