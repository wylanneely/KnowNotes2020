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
     //   GameCenterManager.manager.viewController = self
        displayGKAccessPoint()
        
        
    
    }
    
    func displayGKAccessPoint(){
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.isActive = true
    }
 
    //MARK: Outlets & Actions
    
    @IBAction func showGameCenterDashboard(_ sender: Any) {
        GameCenterManager.manager.presentGameCenterDashboard()
    }
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
           self.dismiss(animated: true, completion: nil)
       }

}
