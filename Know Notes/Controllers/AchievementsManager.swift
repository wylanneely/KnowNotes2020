//
//  AchievementsManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//


import GameKit


struct AchievementsManager {
    
    
    let acousticGuitarInstrumentAchievement = GKAchievement(identifier: "")
    
    func unlockAcousticGuitar(score: Int) {
        if score >= 20 {
            acousticGuitarInstrumentAchievement.percentComplete = 100.00
            reportAchievement(acousticGuitarInstrumentAchievement)
        } else {
           let completePercent =  Double(score) / 20
            acousticGuitarInstrumentAchievement.percentComplete = completePercent
            reportAchievement(acousticGuitarInstrumentAchievement)
        }
        
    }
    
    
    func reportAchievement(_ achievement: GKAchievement) {
        GKAchievement.report([achievement]) {  error in
            if let error = error {
            print("\(error)") }
        }
    }

    
}
