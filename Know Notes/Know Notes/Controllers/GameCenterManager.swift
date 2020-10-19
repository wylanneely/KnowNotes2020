//
//  GameCenterManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit


final class GameCenterManager: NSObject, GKGameCenterControllerDelegate, GKLocalPlayerListener {
    
    static let manager = GameCenterManager()
    
    override init() {
        super.init()
        authenticateGKLocalPlayer()
    }
    
    func authenticateGKLocalPlayer() {
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if GKLocalPlayer.local.isAuthenticated {
                GKLocalPlayer.local.loadPhoto(for: .normal) { (image, error) in
                    if let image = image {
                        self.localPlayerPhoto = image
                    }
                }
                NotificationCenter.default.post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)
                GKLocalPlayer.local.register(self)
            } else if let vc = gcAuthVC {
                self.viewController?.present(vc, animated: true)
            } else {
                print("Error authentication to GameCenter: " +
                        "\(error?.localizedDescription ?? "none")") }
        }
    }
    
    
    //MARK: Properties

    static var isAuthenticated: Bool {
        return GKLocalPlayer.local.isAuthenticated
    }
    
    let leaderboardsManager = LeaderboardsManager()
    
    var viewController: UIViewController?
    var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?
    var currentMatch: GKTurnBasedMatch?
    
    typealias CompletionBlock = (Error?) -> Void
    
    var localPlayerPhoto: UIImage?
    
    
    enum GameCenterHelperError: Error {
        case matchNotFound
    }
    
    
    
    //MARK: GKGameCenter ViewControllers
    var gameCenterDashboardVC = GKGameCenterViewController(state: .achievements)
    
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
    
//    func submitScoreToLeaderboard(){
//        GKLeaderboard.submitScore(10, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["com.wylan.nineknights.leaderboards"]) { (error) in
//
//        }
//    }
      
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterDashboardVC.dismiss(animated: true, completion: nil)
    }
        

}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
