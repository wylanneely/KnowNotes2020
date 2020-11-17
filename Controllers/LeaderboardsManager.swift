//
//  LeaderboardsManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/18/20.
//

import GameKit


struct LeaderboardsManager {
       
    func submit(score: Int, to leaderboard: LeaderboardBundleIDs){
        GKLeaderboard.submitScore(score, context: 0,
                                  player: GKLocalPlayer.local,
                                  leaderboardIDs: [leaderboard.rawValue]) { (error) in
            if let error = error {
                print(error.localizedDescription) } }
    }
    
    //MARK: UserDefaults for unlocking visuals and notes
    
    let defaults = UserDefaults.standard
    
    //MARK: check if round isFinished
    
    var didFinishGrandPianoRound1: Bool {
        return defaults.bool(forKey: kGrandPianoRound1)
    }
    var didFinishGrandPianoRound2: Bool {
        return defaults.bool(forKey: kGrandPianoRound2)
    }
    var didFinishAcousticGuitarRound1: Bool {
        return defaults.bool(forKey: kAcousticGuitarRound1)
    }
    var didFinishAcousticGuitarRound2: Bool {
        return defaults.bool(forKey: kAcousticGuitarRound2)
    }
    
    //MARK: Round Completed Functions
    //call after completing rounds
    func finishedRound1GrandPianoNotes(){
        defaults.setValue(true, forKey: kGrandPianoRound1)
    }
    func finishedRound2GrandPianoNotes(){
        defaults.setValue(true, forKey: kGrandPianoRound2)
    }
    func finishedRound1AcousticGuitarNotes(){
        defaults.setValue(true, forKey: kAcousticGuitarRound1)
    }
    func finishedRound2AcousticGuitarNotes(){
        defaults.setValue(true, forKey: kAcousticGuitarRound2)
    }
    
    let kGrandPianoRound1 = "GrandPianoRound1"
    let kGrandPianoRound2 = "GrandPianoRound2"
    let kAcousticGuitarRound1 = "AcousticGuitarRound1"
    let kAcousticGuitarRound2 = "AcousticGuitarRound2"
   
}

enum LeaderboardBundleIDs: String {
    case regularGrandPiano = "com.wylan.KnowYourNote2020.leaderboards.GPNHS"
    case regularAcousticGuitar = "com.wylan.KnowYourNote2020.leaderboards.AGRHS"
    case advancedGrandPiano = "com.wylan.KnowYourNote2020.leaderboards.GPAHS"
    case advancedAcousticGuitar = "com.wylan.KnowYourNote2020.leaderboards.AGAHS"
}
