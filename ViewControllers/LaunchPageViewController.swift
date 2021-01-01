//
//  ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit


class LaunchPageViewController: UIViewController {
    
    
   private var language: String = NSLocalizedString("AppLanguage", comment: "to help adjust certain views/settings")
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterManager.manager.viewController = self
        registerNotification()
        setUPButtons()
        let modelType = UIDevice.modelName
        print(modelType)
    }
    
    
    //MARK: Set Up
    func setUPButtons(){
        let launchScreenGif = NSLocalizedString("LaunchScreenGif", comment: "gif of logo animating")
         let gifImage = UIImage.gifImageWithName(name: launchScreenGif)
         gif.image = gifImage
        
        let offlineTitle = NSLocalizedString("OfflineButtonTitle",comment: "button title for offline play")
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = 10
        offlineButton.layer.borderWidth = 1
        offlineButton.layer.cornerRadius = 10
        offlineButton.setTitle(offlineTitle, for: .normal)
        if language == "Chinese" {
            setUpChineseViews()
        } else {
            signInButton.layer.borderColor = UIColor.coralRed.cgColor
            offlineButton.layer.borderColor = UIColor.discoDayGReen.cgColor
        }
    }
    
    func setUpChineseViews(){
        signInButton.layer.borderColor = UIColor.chinaRed.cgColor
        offlineButton.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor.systemYellow
    }
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var gif: UIImageView!
    @IBOutlet weak var offlineButton: UIButton!
    
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
        //MARK: In App Payments Begin
        Session.manager.getIAPProducts()
        
       let launchScreenGif = NSLocalizedString("LaunchScreenGif", comment: "gif of logo animating")
        let gifImage = UIImage.gifImageWithName(name: launchScreenGif)
        gif.image = gifImage
        signInButton.isEnabled = notification.object as? Bool ?? false
        let startTitle = NSLocalizedString("StartButtonTitle", comment: "Start Learning")
        signInButton.setTitle(startTitle, for: .normal)
        signInButton.pulsate()
        if language == "Chinese" {
            signInButton.backgroundColor = UIColor.white
            signInButton.setTitleColor(UIColor.chinaRed, for: .normal)
            offlineButton.setTitleColor(UIColor.black, for: .normal)
            signInButton.layer.borderColor = UIColor.chinaRed.cgColor
        } else {
        signInButton.setTitleColor(UIColor.discoDayGReen, for: .normal)
        signInButton.layer.borderColor = UIColor.discoDayGReen.cgColor
        }
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayerGameMenuViewController {
            if segue.identifier == "toLocalPlayerMenu" {
                GameCenterManager.manager.isOnline = true
            }
            if segue.identifier == "toOfflineMode" {
                GameCenterManager.manager.isOnline = false
            }
            GameCenterManager.manager.viewController = vc
        }
    }
    
    //    func checkDevice(){
    //        if UIDevice.current.modelName == "x86_64" {
    //            print("iPhone8")
    //        } else {
    //            print("iPhoneLarger")
    //        }
    //    }
    
}



