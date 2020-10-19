//
//  ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit

class LaunchPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // GameCenterManager.manager.viewController = self
        registerNotification()
    }
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if GKLocalPlayer.local.isAuthenticated {
            self.performSegue(withIdentifier: "toLocalPlayerMenu", sender: self)
        } else {
            GameCenterManager.manager.viewController = self
            GameCenterManager.manager.authenticateGKLocalPlayer()
        }
    }
    
    // MARK: - Notifications
      func registerNotification(){
          NotificationCenter.default.addObserver(
            self,
            selector: #selector(authenticationChanged(_:)),
            name: .authenticationChanged,
            object: nil
          )
      }

    @objc private func authenticationChanged(_ notification: Notification) {
      signInButton.isEnabled = notification.object as? Bool ?? false
        signInButton.setTitle("Start", for: .normal)
        signInButton.setTitleColor(.systemGreen, for: .normal)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LocalPlayerMenuViewController {
            GameCenterManager.manager.viewController = vc
        }
    }
}

