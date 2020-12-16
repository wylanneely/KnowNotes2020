//
//  GameLessonController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation
import StoreKit

class Session {

    static let manager = Session()
    static var leaderboard = LeaderboardsManager()
    
    
    var currentInstrumentType: InstrumentType = .grandPiano
    let sessionInstruments = Instruments()
    typealias CompletionHandler = (Bool) -> Void

    
    var isCustomModeLocked: Bool {
        switch currentInstrumentType {
        case .acousticGuitar:
            return true
            //TODO
        case .grandPiano:
            return false
        case .violin:
            return true
        case .saxaphone:
            return true
        }
    }
    
    
    var isCustomSession: Bool = false
    var customInstrument: Instrument?
    
    var instrument: Instrument {
        switch currentInstrumentType {
        case .acousticGuitar:
            return sessionInstruments.acousticGuitar
        case .grandPiano:
            return sessionInstruments.grandPiano
        case .violin:
            return sessionInstruments.violin
        case .saxaphone:
            return sessionInstruments.saxaphone
        }
    }
    
    var lifes: Int = 5
    var score: Int = 0
    
    func resetScores(){
        lifes = 5
        score = 0
    }
    
    var sessionNotes: [Note] = []
    var roundNumber: Int = 1

    //advancedOptions
    
    
    var hasHalfNotes: Bool = false
    var shuffleMode: ShuffleMode = .off
    
    
    var isShuffleModeUnlocked: Bool {
        switch currentInstrumentType {
        case .grandPiano:
           return LeaderboardsManager().didFinishGrandPianoRound1
        case .acousticGuitar:
            return LeaderboardsManager().didFinishAcousticGuitarRound1
        case .violin:
            return LeaderboardsManager().didFinishViolinRound1
        case .saxaphone:
            return LeaderboardsManager().didFinishSaxRound1
        }
    }
    
    var isHalfNotesUnLocked: Bool {
        switch currentInstrumentType {
        case .grandPiano:
            return LeaderboardsManager().isGrandPianoHalfsNotesUnlocked
        case .acousticGuitar:
            return LeaderboardsManager().didFinishAcousticGuitarRound1
        case .violin:
            return LeaderboardsManager().didFinishViolinRound2
        case .saxaphone:
            return LeaderboardsManager().didFinishSaxRound2
        }
    }
    
    var iAPurchases = InAppPurchases()
    
    func getIAPProducts(){
        IAPManager.shared.getProducts { (result) in
            switch result {
            case .success(let products): self.iAPurchases.products = products
                self.updateGameDataWithPurchasedProduct(self.iAPurchases.products)
            case .failure(let error): print(error)
            }
        }
    }
    
    fileprivate func updateGameDataWithPurchasedProduct(_ products: [SKProduct]) {
            // Update the proper game data depending on the keyword the
            // product identifier of the give product contains.
        for p in products {
            if p.productIdentifier.contains("gphn") {
                
            }
            
        }
    }
    
    
    //MARK: Note Helpers 

    var currentNote: Note?
    var note1: Note?
    var note2: Note?
    var note3: Note?
    lazy var round1Notes: [Note]  = [note1!, note2!, note3!]
    var note4: Note?
    var note5: Note?
    lazy var round2Notes: [Note] = [note1!, note2!, note3!, note4!, note5!]
    var note6: Note?
    var note7: Note?
    lazy var round3Notes: [Note] = [note1!, note2!, note3!, note4!, note5!, note6!, note7!]
    
    //MARK: Set UP
    
    func tCustomOn(){
        isCustomSession = true
        switch currentInstrumentType {
        case .acousticGuitar:
            customInstrument = AcousticGuitar()
        case .grandPiano:
            customInstrument = GrandPiano()
        case .violin:
            customInstrument = Violin()
        case .saxaphone:
            customInstrument = Saxaphone()
        }
    }
    func tCustomOff(){
        isCustomSession = false
        customInstrument = nil
    }
    
    func setGrandPianoSession() {
        currentInstrumentType = .grandPiano
    }
    func setAcousticSession() {
        currentInstrumentType = .acousticGuitar
    }
    func setViolinSession() {
        currentInstrumentType = .violin
    }
    func setSaxophoneSession() {
        currentInstrumentType = .saxaphone
    }
    
    //MARK: Round 1
    
    func reuseRound1NoteSet(){
       var unRandomizedSet: [Note] = []
        for notte in sessionNotes {
            let unRando = notte
            unRando.isRandomlySelected = false
            unRandomizedSet.append(unRando)
        }
        sessionNotes = unRandomizedSet
        round1Notes = unRandomizedSet
    }
    
    func isRound1fullyRandomized() -> Bool {
        var fullRando = false
        for notee in round1Notes {
            if notee.isRandomlySelected == false  {
                fullRando = false
                return fullRando
            } else {
                fullRando = true
            }
        }
        return fullRando
    }
    
    func setRound1Notes(completion: CompletionHandler){
        roundNumber = 1
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.round1Notes
            reuseRound1NoteSet()

        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.round1Notes
            reuseRound1NoteSet()

        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round1Notes
            reuseRound1NoteSet()

        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round1Notes
            reuseRound1NoteSet()

        }
        round1Notes = sessionNotes
        completion(true)
    }
    
    func randomizeCustomRound1() {
        if let instrum = self.instrument as? GrandPiano {
            instrum.refreshCustomRound1Notes()
            note1 = instrum.cRound1Notes[0]
            note2 = instrum.cRound1Notes[1]
            note3 = instrum.cRound1Notes[2]
            round1Notes = [note1!,note2!,note3!]
        }
        if let instrum = self.instrument as? AcousticGuitar {
      //todo
        }
    }
    
    func setCustomRound1Notes(completion: CompletionHandler){
        roundNumber = 1
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.allCustomRound1Notes
            note1 = instrum.cRound1Notes[0]
            note2 = instrum.cRound1Notes[1]
            note3 = instrum.cRound1Notes[2]
            round1Notes = [note1!,note2!,note3!]
        }
        if let instrum = self.instrument as? AcousticGuitar {
      //todo
        }
        completion(true)
    }
    
    func setRound1HalfNotes(completion: CompletionHandler){
        roundNumber = 1
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.sharpsFlatsRound1
            reuseRound1NoteSet()
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.minorMajorChordsRound1
            reuseRound1NoteSet()

        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round2Notes
            reuseRound1NoteSet()

        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round2Notes
            reuseRound1NoteSet()

        }
        round1Notes = sessionNotes
        completion(true)
    }
    
    //MARK: Round 2

    func reuseRound2NoteSet(){
       var unRandomizedSet: [Note] = []
        for notte in sessionNotes {
            let unRando = notte
            unRando.isRandomlySelected = false
            unRandomizedSet.append(unRando)
        }
        sessionNotes = unRandomizedSet
        round2Notes = unRandomizedSet
    }
    
    func isRound2fullyRandomized() -> Bool {
        var fullRando = false
        for notee in round2Notes {
            if notee.isRandomlySelected == false  {
                fullRando = false
                return fullRando
            } else {
                fullRando = true
            }
        }
        return fullRando
    }
    
    func setRound2Notes(completion: CompletionHandler){
        roundNumber = 2
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.round2Notes
            reuseRound2NoteSet()
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.round2Notes
            reuseRound2NoteSet()
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round2Notes
            reuseRound2NoteSet()
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round2Notes
            reuseRound2NoteSet()
        }
        completion(true)
        round2Notes = sessionNotes
    }
    
    func setCustomRound2Notes(completion: CompletionHandler){
        roundNumber = 2
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.allCustomRound2Notes
            note1 = instrum.cRound2Notes[0]
            note2 = instrum.cRound2Notes[1]
            note3 = instrum.cRound2Notes[2]
            note4 = instrum.cRound2Notes[3]
            note5 = instrum.cRound2Notes[4]
            round2Notes = [note1!,note2!,note3!,note4!,note5!]
        }
        
        if let instrum = self.instrument as? AcousticGuitar {
        //todo
        }
        completion(true)
    }
    
    func setRound2HalfNotes(completion: CompletionHandler){
        roundNumber = 2
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.sharpsFlatsRound2
            reuseRound2NoteSet()
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.minorMajorChordsRound2
            reuseRound2NoteSet()
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round2Notes
            reuseRound2NoteSet()
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round2Notes
            reuseRound2NoteSet()
        }
        round2Notes = sessionNotes
        completion(true)
    }
    
    //MARK: Round 3
    
    func reuseRound3NoteSet(){
       var unRandomizedSet: [Note] = []
        for notte in sessionNotes {
            let unRando = notte
            unRando.isRandomlySelected = false
            unRandomizedSet.append(unRando)
        }
        sessionNotes = unRandomizedSet
        round3Notes = unRandomizedSet
    }
    func isRound3fullyRandomized() -> Bool {
        var fullRando = false
        for notee in round3Notes {
            if notee.isRandomlySelected == false  {
                fullRando = false
                return fullRando
            } else {
                fullRando = true
            }
        }
        return fullRando
    }
    
    func setCustomRound3Notes(completion: CompletionHandler){
        roundNumber = 3
        if let instrum = self.instrument as? GrandPiano {
          sessionNotes = instrum.allCustomRound3Notes
            note1 = instrum.cRound2Notes[0]
            note2 = instrum.cRound2Notes[1]
            note3 = instrum.cRound2Notes[2]
            note4 = instrum.cRound2Notes[3]
            note5 = instrum.cRound2Notes[4]
            note6 = instrum.cRound2Notes[3]
            note7 = instrum.cRound2Notes[4]
            round2Notes = [note1!,note2!,note3!,note4!,note5!,note6!,note7!]
        }
        if let instrum = self.instrument as? AcousticGuitar {
        //todo
        }
        completion(true)
    }
    
    func setRound3Notes(completion: CompletionHandler){
        roundNumber = 3
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.round3Notes
            reuseRound3NoteSet()
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.round3Notes
            reuseRound3NoteSet()

        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round3Notes
            reuseRound3NoteSet()

        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round3Notes
            reuseRound3NoteSet()

        }
        round3Notes = sessionNotes
        completion(true)
    }
    
    func setRound3HalfNotes(completion: CompletionHandler){
        roundNumber = 3
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.sharpsFlatsRound3
            reuseRound3NoteSet()

        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.minorChordsRound3
            reuseRound3NoteSet()

        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round3Notes
            reuseRound3NoteSet()

        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round3Notes
            reuseRound3NoteSet()

        }
        round3Notes = sessionNotes
        completion(true)
    }
    
    //MARK: Future Rounds
    
    func setRound4HalfNotes(){
        roundNumber = 4
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.round2Notes
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.round2Notes
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round2Notes
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round2Notes
        }
        round1Notes = sessionNotes
    }
    
    //MARK: Note Session Functions
    
    func getNewNote(notes: [Note?])-> (nextNote:Note?, noteSet:[Note?] ) {
        var noteCopy = notes
        var newNoteSet: [Note?] = []
        var newNote: Note? = nil
        let iterations = notes.count
        var noteIteration = 1
        repeat {
            if let nextNote = noteCopy.randomElement() {
                if newNote == nil {
                    if nextNote?.isRandomlySelected == false {
                        nextNote?.isRandomlySelected = true
                        newNote = nextNote
                        newNoteSet.append(newNote)
                        noteCopy.remove(object: nextNote)
                        noteIteration += 1
                    } else {
                        noteIteration += 1
                        newNoteSet.append(nextNote)
                        noteCopy.remove(object: nextNote)
                    }
                } else {
                        noteIteration += 1
                        noteCopy.remove(object: nextNote)
                        newNoteSet.append(nextNote)
                }
            }
        } while noteIteration <= iterations
        currentNote = newNote
        return (newNote,newNoteSet)
    }
    
    func getNextNote() -> Note? {
        if shuffleMode == .locked || shuffleMode == .off {
            let newNote = sessionNotes.randomElement()
            currentNote = newNote
            return newNote
        }
        
        let randomSelected = false
        repeat {
            let nextNote = sessionNotes.randomElement()
            if nextNote?.isRandomlySelected == false {
                switch roundNumber {
                case 1:
                    DispatchQueue.main.async {
                        self.round1Notes.remove(object: nextNote!)
                        self.sessionNotes.remove(object: nextNote!)
                        nextNote?.isRandomlySelected = true
                        self.currentNote = nextNote
                        self.round1Notes.append(nextNote!)
                        self.sessionNotes.append(nextNote!)
                    }
                    return nextNote
                case 2:
                    DispatchQueue.main.async {
                        self.round2Notes.remove(object: nextNote!)
                        self.sessionNotes.remove(object: nextNote!)
                        nextNote?.isRandomlySelected = true
                        self.currentNote = nextNote
                        self.round2Notes.append(nextNote!)
                        self.sessionNotes.append(nextNote!)
                    }
                    return nextNote
                case 3:
                    DispatchQueue.main.async {
                        self.round3Notes.remove(object: nextNote!)
                        self.sessionNotes.remove(object: nextNote!)
                        nextNote?.isRandomlySelected = true
                        self.currentNote = nextNote
                        self.round3Notes.append(nextNote!)
                        self.sessionNotes.append(nextNote!)
                    }
                    return nextNote
                default:
                    break
                }
            }
        }  while randomSelected == false
        
    }

    
    func checkUpdateSessionWith(note: Note) -> Bool {
        if isNoteSelectionCorrect(note: note) {
            score += 1
            return true
        } else {
            lifes -= 1
            return false
        }
    }
    private func isNoteSelectionCorrect(note: Note) -> Bool {
         if note.id == currentNote?.id {
             return true
         } else {
             return false
         }
     }
    func getSoundPathURLFromNote(path: String?) -> URL? {
        if let path = path {
            let soundPath = Bundle.main.path(forResource: path, ofType: nil)!
            let url = URL(fileURLWithPath: soundPath)
            return url
        }
        return nil
    }
    
}
