//
//  AchievementsManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//


import GameKit


 class AchievementsManager {
    
    private var userDefaultsHelper = LeaderboardsManager()

    //MARK: Achievements
    
    var playerAchievements: [GKAchievement]?

    let acousticGuitarAchievement = GKAchievement(identifier: AchievementsBundleIDs.unlockAcousticGuitar.rawValue)
    let violinAchievement = GKAchievement(identifier: AchievementsBundleIDs.unlockViolin.rawValue)
    let saxaphoneAchievement = GKAchievement(identifier: AchievementsBundleIDs.unlockSaxaphone.rawValue)
    
    var isAcousticGuitarUnlocked: Bool = false
    var isViolinUnlocked: Bool = false
    var isSaxUnlocked: Bool = false

    //MARK; Load & Sort Achievements
    
    func loadAchievements(sucess: SuccessHandler) {
        var didLoad: Bool = false
        GKAchievement.loadAchievements { (achievements, error) in
            if let achievements = achievements {
                self.playerAchievements = achievements
                self.sortCompletedAchievements()
                didLoad = true
            } else {
                didLoad = false
            }
        }
        sucess(didLoad)
    }
    
    func sortCompletedAchievements(){
        if let pAchievements = playerAchievements {
            for achievement in pAchievements {
                switch achievement.identifier {
                case AchievementsBundleIDs.unlockAcousticGuitar.rawValue :
                    self.isAcousticGuitarUnlocked = achievement.isCompleted
                case AchievementsBundleIDs.unlockViolin.rawValue :
                    self.isViolinUnlocked = achievement.isCompleted
                case AchievementsBundleIDs.unlockSaxaphone.rawValue :
                    self.isSaxUnlocked = achievement.isCompleted
                default:
                    return } }
        }
    }
    
    typealias SuccessHandler = (Bool) -> Void

    func reportSaxaphoneProgress(with score: Int) {
        if score >= 20 {
            saxaphoneAchievement.percentComplete = 100.00
            reportAchievement(saxaphoneAchievement)
            userDefaultsHelper.unlockSaxLocally()
        } else {
           let completePercent =  Double(score) / 20
            saxaphoneAchievement.percentComplete = completePercent
            reportAchievement(saxaphoneAchievement)
        }
    }
    
    func reportViolinProgress(with score: Int) {
        if score >= 20 {
            violinAchievement.percentComplete = 100.00
            reportAchievement(violinAchievement)
            userDefaultsHelper.unlockViolinLocally()
        } else {
           let completePercent =  Double(score) / 20
            violinAchievement.percentComplete = completePercent
            reportAchievement(violinAchievement)
        }
    }
    
    func reportUnlockAcousticGuitarProgress(with score: Int) {
        if score >= 20 {
            acousticGuitarAchievement.percentComplete = 100.00
            reportAchievement(acousticGuitarAchievement)
            userDefaultsHelper.unlockAcousticGuitarLocally()
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
    case unlockViolin = "com.wylan.KnowYourNote2020.Achievements.Violin"
    case unlockSaxaphone = "com.wylan.KnowYourNote2020.Achievements.Sax"

}
