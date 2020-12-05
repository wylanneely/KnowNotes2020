//
//  GameLessonController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class LessonSession {

    static let manager = LessonSession()
    
   private var lesson: Lesson = Lesson(instrument: Instrument(type: .grandPiano, notes: []), noteGroups: .wholeNotes)
    let piano = GrandPiano()
    //MARK: GameSession Scores & Life
    
    var lifes: Int = 5
    var score: Int = 0
    
    func resetScores(){
        lifes = 5
        score = 0
    }
    
    //MARK: Set UP
    
    var sessionNotes: [Note] = []
    var hasHalfNotes: Bool = false
    var roundNumber: Int = 1
    
    func setRound1Notes(){
        roundNumber = 1
        sessionNotes = lesson.round1Notes
        hasHalfNotes = false
    }
    
    func setRound1HalfNotes(){
        roundNumber = 1
        sessionNotes = piano.sharpsFlatsRound1
        round1Notes = sessionNotes
        hasHalfNotes = true
    }
    
    func setRound2Notes(){
        roundNumber = 2
        sessionNotes = lesson.round2Notes
        hasHalfNotes = false

    }
    func setRound3Notes(){
        roundNumber = 3
        sessionNotes = lesson.round3Notes
        hasHalfNotes = false

    }
    
    func setGrandPianoLesson() {
        let instreument = Instrument(type: .grandPiano, notes: [])
        let aLesson = Lesson(instrument: instreument, noteGroups: .allNotes)
        let instrum = GrandPiano()
        aLesson.grandPiano = instrum
        self.lesson = aLesson
    }
    func setAcousticLesson() {
        let instreument = Instrument(type: .acousticGuitar, notes: [])
        let aLesson = Lesson(instrument: instreument, noteGroups: .allNotes)
        self.lesson = aLesson
    }
    func setViolinLesson() {
        let instreument = Instrument(type: .violin, notes: [])
        let aLesson = Lesson(instrument: instreument, noteGroups: .allNotes)
        self.lesson = aLesson
    }
    func setSaxophoneLesson() {
        let instreument = Instrument(type: .saxaphone, notes: [])
        let aLesson = Lesson(instrument: instreument, noteGroups: .allNotes)
        self.lesson = aLesson
    }
    
    //MARK: Note Handlers
    
    var currentNote: Note?
    
    var note1: Note?
    var note2: Note?
    var note3: Note?
    
    lazy var round1Notes: [Note]  = [note1!, note2!, note3!]
    
    var isRound1fullyRandomized: Bool {
        if (note1?.isRandomlySelected == true) &&
            (note2?.isRandomlySelected == true) &&
            (note3?.isRandomlySelected == true)  {
            return true
        } else {
            return false
        }
    }
    
    var note4: Note?
    var note5: Note?
    var note6: Note?
    var note7: Note?
    
   
    
    func getNextNote() -> Note? {
        if hasHalfNotes {
            let noteToReturn: Note = Note(name: "", id: 0)
            
            repeat {
                var nextNote = sessionNotes.randomElement()
                if nextNote?.isRandomlySelected == false {
                    round1Notes.remove(object: nextNote!)
                    sessionNotes.remove(object: nextNote!)
                    nextNote?.isRandomlySelected = true
                    round1Notes.append(nextNote!)
                    sessionNotes.append(nextNote!)
                    currentNote = nextNote
                    return nextNote
                }
            }  while noteToReturn.isRandomlySelected == false
            
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
