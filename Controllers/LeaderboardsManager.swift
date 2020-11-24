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
    
    func getHighScoreGrandPiano() -> Int {
        return defaults.integer(forKey: kHighScoreGrandPiano)
    }
    
    func highScoreAcousticGuitar() -> Int {
        return defaults.integer(forKey: kHighScoreAGuitar)
    }
    
    func highScoreViolin() -> Int {
        return defaults.integer(forKey: kHighScoreViolin)
    }
    
    func highScoreSax() -> Int {
        return defaults.integer(forKey: kHighScoreSaxaphone)
    }
    //MARK: Instrument helper
    
    var isAcousticGuitarUnlocked: Bool {
        if defaults.bool(forKey: kIsAcousticUnlocked) == true {
            return true
        } else {
            return GameCenterManager.manager.achievementsManager.isAcousticGuitarUnlocked
        }
    }
    
    var isViolinUnlocked: Bool  {
        if defaults.bool(forKey: kIsViolinUnlocked) == true {
            return true
        } else {
            return GameCenterManager.manager.achievementsManager.isViolinUnlocked
        }
    }
    var isSaxaphoneUnlocked: Bool  {
        if defaults.bool(forKey: kIsSaxaphoneUnlocked) == true {
            return true
        } else {
            return GameCenterManager.manager.achievementsManager.isSaxUnlocked
        }
    }
    
    func unlockAcousticGuitarLocally(){
        defaults.setValue(true, forKey: kIsAcousticUnlocked)
    }
    func  unlockViolinLocally(){
        defaults.setValue(true, forKey: kIsViolinUnlocked)
    }
    func  unlockSaxLocally(){
        defaults.setValue(true, forKey: kIsSaxaphoneUnlocked)
    }
    
    //MARK: check if round isFinished
    
    var didFinishGrandPianoRound1: Bool {
        return defaults.bool(forKey: kGrandPianoRound1)
    }
    var didFinishGrandPianoRound2: Bool {
        return defaults.bool(forKey: kGrandPianoRound2)
    }
    var didunlockAcousticGuitar: Bool {
        return defaults.bool(forKey: kAcousticGuitarRound1)
    }
    var didFinishAcousticGuitarRound1: Bool {
        return defaults.bool(forKey: kAcousticGuitarRound1)
    }
    var didFinishAcousticGuitarRound2: Bool {
        return defaults.bool(forKey: kAcousticGuitarRound2)
    }
    var didFinishViolinRound1: Bool {
        return defaults.bool(forKey: kViolinRound1)
    }
    var didFinishViolinRound2: Bool {
        return defaults.bool(forKey: kViolinRound2)
    }
    var didFinishSaxRound1: Bool {
        return defaults.bool(forKey: kSaxRound1)
    }
    var didFinishSaxRound2: Bool {
        return defaults.bool(forKey: kSaxRound2)
    }
    
    //MARK: Local HighScores
    //call after completing rounds
    
    func setPersonalGranPianoHighScore(score: Int){
        defaults.setValue(score, forKey: kHighScoreGrandPiano)
        if score >= 20 {
            unlockAcousticGuitarLocally()
        }
    }
    func setPersonalAcouGuitarHighScore(score: Int){
        defaults.setValue(score, forKey: kHighScoreAGuitar)
        if score >= 20 {
            unlockViolinLocally()
        }
    }
    func setPersonalViolinHighScore(score: Int){
        defaults.setValue(score, forKey: kHighScoreViolin)
        if score >= 20 {
            unlockSaxLocally()
        }
    }
    func setPersonalSaxaphoneHighScore(score: Int){
        defaults.setValue(score, forKey: kHighScoreSaxaphone)
    }
    
    //MARK: Local Rounds

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
    func finishedRound1ViolinNotes(){
        defaults.setValue(true, forKey: kViolinRound1)
    }
    func finishedRound2ViolinNotes(){
        defaults.setValue(true, forKey: kViolinRound2)
    }
    func finishedRound1SaxNotes(){
        defaults.setValue(true, forKey: kSaxRound1)
    }
    func finishedRound2SaxNotes(){
        defaults.setValue(true, forKey: kSaxRound2)
    }
    
    fileprivate let kIsAcousticUnlocked = "isAcousticUnlocked"
    fileprivate let kIsViolinUnlocked = "isViolinUnlocked"
    fileprivate let kIsSaxaphoneUnlocked = "isSaxaphoneUnlocked"


    fileprivate let kGrandPianoRound1 = "GrandPianoRound1"
    fileprivate let kGrandPianoRound2 = "GrandPianoRound2"
    
    fileprivate let kAcousticGuitarRound1 = "AcousticGuitarRound1"
    fileprivate let kAcousticGuitarRound2 = "AcousticGuitarRound2"
    
    fileprivate let kViolinRound1 = "ViolinRound1"
    fileprivate let kViolinRound2 = "ViolinRound2"
    
    fileprivate let kSaxRound1 = "SaxRound1"
    fileprivate let kSaxRound2 = "SaxRound2"
   
    fileprivate let kHighScoreGrandPiano = "GrandPianoHS"
    fileprivate let kHighScoreAGuitar = "AcousticGuitarHS"
    fileprivate let kHighScoreViolin = "ViolinHS"
    fileprivate let kHighScoreSaxaphone = "SaxaphoneHS"


}

enum LeaderboardBundleIDs: String {
    case regularGrandPiano = "com.wylan.KnowYourNote2020.leaderboards.GPNHS"
    case regularAcousticGuitar = "com.wylan.KnowYourNote2020.leaderboards.AGRHS"
    case regularViolin = "com.wylan.KnowYourNote2020.leaderboards.VRHS"
    case regularSaxaphone = "com.wylan.KnowYourNote2020.leaderboards.SHS"
    case advancedGrandPiano = "com.wylan.KnowYourNote2020.leaderboards.GPAHS"
    case advancedAcousticGuitar = "com.wylan.KnowYourNote2020.leaderboards.AGAHS"
}
