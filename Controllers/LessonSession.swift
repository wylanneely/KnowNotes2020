//
//  GameLessonController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class LessonSession {

    var lifes: Int = 5
    var score: Int = 0
    
    static let manager = LessonSession()
    
    var lesson: Lesson = Lesson(instrument: Instrument(type: .grandPiano, notes: []), noteGroups: .wholeNotes)
    
    func setAcousticLesson() {
        let instreument = Instrument(type: .acousticGuitar, notes: [])
        let aLesson = Lesson(instrument: instreument, noteGroups: .allNotes)
        self.lesson = aLesson
    }
    func setGrandPianoLesson() {
        let instreument = Instrument(type: .grandPiano, notes: [])
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
    
    lazy var sessionNotes: [Note] = lesson.round1Notes
    
    func setRound1Notes(){
        sessionNotes = lesson.round1Notes
    }
    
    func setRound2Notes(){
        sessionNotes = lesson.round2Notes
    }
    func setRound3Notes(){
        sessionNotes = lesson.round3Notes
    }
    
    var currentNote: Note?
    
    func resetScores(){
        lifes = 5
        score = 0
    }
    
    func getNextNote() -> Note? {
        let newNote = sessionNotes.randomElement()
        currentNote = newNote
        return newNote
    }
    
   private func isNoteSelectionCorrect(note: Note) -> Bool {
        if note.id == currentNote?.id {
            return true
        } else {
            return false
        }
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
    
    func getSoundPathURLFromNote(path: String?) -> URL? {
        if let path = path {
            let soundPath = Bundle.main.path(forResource: path, ofType: nil)!
            let url = URL(fileURLWithPath: soundPath)
            return url
        }
        return nil
    }
    
}
