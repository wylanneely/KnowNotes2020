//
//  GameCenterManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit


final class GameCenterManager: NSObject, GKGameCenterControllerDelegate, GKLocalPlayerListener {
    
    static let manager = GameCenterManager()
    
    var isOnline: Bool = false

    var leaderboardsManager = LeaderboardsManager()
    var achievementsManager = AchievementsManager()
    
    var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?
    var currentMatch: GKTurnBasedMatch?
    
    var viewController: UIViewController?
    var localPlayerPhoto: UIImage?

    //MARK:  Set UP
    override init() {
        super.init()
        authenticateGKLocalPlayer { (success) in
            if success {
                achievementsManager.loadAchievements { (_) in
                }
            } }
    }

    func getSetLocalPlayerPhoto(){
        GKLocalPlayer.local.loadPhoto(for: .normal) { (image, error) in
            if let image = image {
                self.localPlayerPhoto = image }
        } }
    
    typealias CompletionBlock = (Error?) -> Void
    typealias SuccessHandler = (Bool) -> Void

    
    //MARK: Authentication
    
    static var isAuthenticated: Bool {
            return GKLocalPlayer.local.isAuthenticated
        }
    enum GameCenterHelperError: Error {
           case matchNotFound
       }
    
    func authenticateGKLocalPlayer(completion: SuccessHandler) {
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if GKLocalPlayer.local.isAuthenticated {
                self.getSetLocalPlayerPhoto()
                NotificationCenter.default.post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)
                GKLocalPlayer.local.register(self)
            } else if let vc = gcAuthVC {
                self.viewController?.present(vc, animated: true)
            } else {
                print("Error authentication to GameCenter: " +
                        "\(error?.localizedDescription ?? "none")") }
        }
        completion(true)
    }
    
    //MARK: View GameCenter dashboards
    var gameCenterDashboardVC = GKGameCenterViewController(state: .default)
    
    func presentGameCenterDashboard(){
        let vc = gameCenterDashboardVC
        gameCenterDashboardVC.gameCenterDelegate = self
        viewController?.present(vc, animated: true, completion: nil)
    }
    var gameCenterPlayerProfileVC = GKGameCenterViewController(
        state: .localPlayerProfile)

    func presentGameCenterProfile(){
        let vc = gameCenterPlayerProfileVC
        gameCenterPlayerProfileVC.gameCenterDelegate = self
        viewController?.present(vc, animated: true, completion: nil)
    }
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterDashboardVC.dismiss(animated: true, completion: nil)
    }

}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
