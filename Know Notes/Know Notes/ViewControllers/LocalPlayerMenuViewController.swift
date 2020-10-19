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
        displayGKAccessPoint()
        localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto
    
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
    
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
           self.dismiss(animated: true, completion: nil)
       }

}
