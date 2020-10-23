//
//  LeaderboardsManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit


struct LeaderboardsManager {
    
    
    func submit(score: Int, to leaderboard: LeaderboardIDs){
        GKLeaderboard.submitScore(score, context: 0,
                                  player: GKLocalPlayer.local,
                                  leaderboardIDs: [leaderboard.rawValue]) { (error) in
            if let error = error {
                print(error.localizedDescription) } }
    }
    
    
}

enum LeaderboardIDs: String {
    case regularGrandPiano = "com.wylan.knowNotes2.leaderboard.GPRHS"
    case regularAcousticGuitar = "com.wylan.knowNotes2.leaderboard.AGRHS"
    case advancedGrandPiano = "com.wylan.knowNotes2.leaderboard.GPAHS"
    case advancedAcousticGuitar = "com.wylan.knowNotes2.leaderboard.AGAHS"
}
