//
//  ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit

class LaunchPageViewController: UIViewController {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        registerNotification()
        setUPButtons()
       // animateimagesWithtwoColors()
        //checkDevice()
    }
    
    //MARK: Set Up
    func setUPButtons(){
        let gifImage = UIImage.gifImageWithName(name: "KnowNotesLogoAnimation")
        gif.image = gifImage
        
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderColor = UIColor.coralRed.cgColor
    }
    
    func checkDevice(){
        
        if UIDevice.current.modelName == "x86_64" {
            print("iPhone8")
        } else {
            print("iPhoneLarger")
        }
    }
   
    //NOTE: this is for the menu image animation
//    func animateimagesWithtwoColors(){
//        UIView.animate(withDuration: 2.5) {
//            self.pianosImage.tintColor = UIColor.discoDayGReen
//            self.guitarsImage.tintColor = UIColor.midnightPurps
//        } completion: {
//            (completed: Bool) -> Void in
//            UIView.animateKeyframes(withDuration: 2.5, delay: 1, options: .repeat) {
//                self.pianosImage.tintColor = UIColor.midnightPurps
//                self.guitarsImage.tintColor = UIColor.discoDayGReen
//            } completion: { (completed: Bool) -> Void in
//                    self.pianosImage.tintColor = UIColor.discoDayGReen
//                self.guitarsImage.tintColor = UIColor.midnightPurps
//            }
//        }
//    }
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var gif: UIImageView!
    
   // @IBOutlet weak var guitarsImage: UIImageView!
   // @IBOutlet weak var pianosImage: UIImageView!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if GKLocalPlayer.local.isAuthenticated {
            self.performSegue(withIdentifier: "toLocalPlayerMenu", sender: self)
        } else {
            GameCenterManager.manager.viewController = self
            GameCenterManager.manager.authenticateGKLocalPlayer { (success) in
            }
        }
    }
    @IBAction func playOfflineTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "toOfflineMode", sender: self)

    }
    
    // MARK: - GameCenter Authentication
    
    func registerNotification(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(authenticationChanged(_:)),
            name: .authenticationChanged,
            object: nil
        )
    }
    
    @objc private func authenticationChanged(_ notification: Notification) {
        
        let gifImage = UIImage.gifImageWithName(name: "KnowNotesLaunchScreen")
        gif.image = gifImage
        
        signInButton.isEnabled = notification.object as? Bool ?? false
        signInButton.setTitle("Start", for: .normal)
        signInButton.pulsate()
        signInButton.setTitleColor(UIColor.discoDayGReen, for: .normal)
        signInButton.layer.borderColor = UIColor.discoDayGReen.cgColor
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayerGameMenuViewController {
            if segue.identifier == "toLocalPlayerMenu" {
                vc.isOnline = true
            }
            GameCenterManager.manager.viewController = vc
        }
        
    }
    
}

