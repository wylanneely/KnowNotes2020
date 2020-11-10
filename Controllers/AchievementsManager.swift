//
//  AchievementsManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//


import GameKit


 class AchievementsManager {
    
    
    var playerAchievements: [GKAchievement]?
    //MARK: Achievements
    let acousticGuitarAchievement = GKAchievement(identifier: AchievementsBundleIDs.unlockAcousticGuitar.rawValue)
    
    var isAcousticGuitarUnlocked: Bool = false
    
    func loadAchievements() {
        GKAchievement.loadAchievements { (achievements, error) in
            if let achievements = achievements {
                self.playerAchievements = achievements
                self.sortCompletedAchievements()
            }
        }
    }
    
   func sortCompletedAchievements(){
        if let pAchievements = playerAchievements {
            for achievement in pAchievements {
                switch achievement.identifier {
                case AchievementsBundleIDs.unlockAcousticGuitar.rawValue :
                    self.isAcousticGuitarUnlocked = achievement.isCompleted
              default:
                    return
                }
            }
        }
   }
    
    func reportUnlockAcousticGuitarProgress(with score: Int) {
        if score >= 20 {
            acousticGuitarAchievement.percentComplete = 100.00
            reportAchievement(acousticGuitarAchievement)
        } else {
           let completePercent =  Double(score) / 20
            acousticGuitarAchievement.percentComplete = completePercent
            reportAchievement(acousticGuitarAchievement)
        }   
    }
    
    func reportAchievement(_ achievement: GKAchievement) {
        GKAchievement.report([achievement]) {  error in
            if let error = error {
            print("\(error)") }
        }
    }

}
enum AchievementsBundleIDs: String {
    case unlockAcousticGuitar = "com.wylan.KnowYourNote2020.Achievements.AcousticGuitar"
}
