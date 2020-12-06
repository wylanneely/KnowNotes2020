//
//  GameLessonController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class Session {

    static let manager = Session()
    
    var currentInstrumentType: InstrumentType = .grandPiano
    let sessionInstruments = Instruments()
    
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
    var hasHalfNotes: Bool = false
    var roundNumber: Int = 1
    
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
    
    func setRound1Notes(){
        roundNumber = 1
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.round1Notes
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.round1Notes
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round1Notes
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round1Notes
        }
        round1Notes = sessionNotes
        hasHalfNotes = false
    }
    
    func setRound1HalfNotes(){
        roundNumber = 1
        
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.sharpsFlatsRound1
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.minorMajorChordsRound1
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round2Notes
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round2Notes
        }
        round1Notes = sessionNotes
        hasHalfNotes = true
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
    func setRound2Notes(){
        roundNumber = 2
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
        round2Notes = sessionNotes
        hasHalfNotes = false
    }
    
    func setRound2HalfNotes(){
        roundNumber = 2
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.sharpsFlatsRound2
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.minorMajorChordsRound2
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round2Notes
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round2Notes
        }
        round1Notes = sessionNotes
        hasHalfNotes = true
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
    func setRound3Notes(){
        roundNumber = 3
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.round3Notes
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.round3Notes
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round3Notes
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round3Notes
        }
        round3Notes = sessionNotes
        hasHalfNotes = false
    }
    
    func setRound3HalfNotes(){
        roundNumber = 3
        if let instrum = self.instrument as? GrandPiano {
            sessionNotes = instrum.sharpsFlatsRound3
        }
        if let instrum = self.instrument as? AcousticGuitar {
            sessionNotes = instrum.minorChordsRound3
        }
        if let instrum = self.instrument as? Violin {
            sessionNotes = instrum.round3Notes
        }
        if let instrum = self.instrument as? Saxaphone {
            sessionNotes = instrum.round3Notes
        }
        round1Notes = sessionNotes
        hasHalfNotes = true
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
        hasHalfNotes = true
    }
    
    //MARK: Note Session Functions
    
    func getNextNote() -> Note? {
        if hasHalfNotes {
            let randomSelected = false
            repeat { //get randomnote in session
                let nextNote = sessionNotes.randomElement()
                    //check if been randomly selected yet, keep pulling until false
                if nextNote?.isRandomlySelected == false {
                    //update
                    round1Notes.remove(object: nextNote!)
                    sessionNotes.remove(object: nextNote!)
                    nextNote?.isRandomlySelected = true
                    round1Notes.append(nextNote!)
                    sessionNotes.append(nextNote!)
                    //set Current note and return
                    currentNote = nextNote
                    return nextNote
                }
            }  while randomSelected == false
            
        } else if hasHalfNotes == false {
            let newNote = sessionNotes.randomElement()
            currentNote = newNote
            return newNote
        }
        return nil
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
