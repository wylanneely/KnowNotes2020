//
//  GameLessonController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class GameLessonManager {
    
    static let manager = GameLessonManager()
    
    var lesson: GameLesson? = GameLesson(instrument: "Grand Piano", noteGroups: .allNotes)
    
    func setLesson(lesson:GameLesson) {
        self.lesson = lesson
    }
    

    var lifes: Int = 5
    var score: Int = 0
    
    var sessionNotes: [Note] = []
    
    var currentNote: Note?
    
    
    func setSessionNotes(){
            self.sessionNotes = lesson?.lessonNotes
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
    
    func checkUpdateSessionWith(note: Note) {
        if isNoteSelectionCorrect(note: note) {
            score += 1
        } else {
            lifes -= 1
        }
    }
    
}
