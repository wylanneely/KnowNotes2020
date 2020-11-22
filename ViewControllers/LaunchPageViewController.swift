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
        animateimagesWithtwoColors()
    }
    
    //MARK: Set Up
    func setUPButtons(){
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = 10
        signInButton.layer.borderColor = UIColor.imperialRed.cgColor
    }
    
    func animateBackgroundWithtwoColors(){
        UIView.animate(withDuration: 1.5) {
            self.view.backgroundColor = UIColor.gameplayBlue
        } completion: { (completed: Bool) -> Void in
            UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModePaced) {
                self.view.backgroundColor = UIColor.seaFoamBlue
            } completion: { (completed: Bool) -> Void in
                self.animateBackgroundWithtwoColors() } }
    }
    
    func animateimagesWithtwoColors(){
        UIView.animate(withDuration: 2.5) {
            self.pianosImage.tintColor = UIColor.discoDayGReen
            self.guitarsImage.tintColor = UIColor.midnightPurps
        } completion: {
            (completed: Bool) -> Void in
            UIView.animateKeyframes(withDuration: 2.5, delay: 1, options: .repeat) {
                self.pianosImage.tintColor = UIColor.midnightPurps
                self.guitarsImage.tintColor = UIColor.discoDayGReen
            } completion: { (completed: Bool) -> Void in
                    self.pianosImage.tintColor = UIColor.discoDayGReen
                self.guitarsImage.tintColor = UIColor.midnightPurps
            }
        }
        
    }
    
    
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var guitarsImage: UIImageView!
    @IBOutlet weak var pianosImage: UIImageView!
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        if GKLocalPlayer.local.isAuthenticated {
            self.performSegue(withIdentifier: "toLocalPlayerMenu", sender: self)
        } else {
            GameCenterManager.manager.viewController = self
            GameCenterManager.manager.authenticateGKLocalPlayer { (success) in
            }
        }
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
        signInButton.isEnabled = notification.object as? Bool ?? false
        signInButton.setTitle("Start", for: .normal)
        signInButton.setTitleColor(UIColor.pastelGReen, for: .normal)
        signInButton.layer.borderColor = UIColor.pastelGReen.cgColor
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayerGameMenuViewController {
            GameCenterManager.manager.viewController = vc
        }
        
    }
    
}

