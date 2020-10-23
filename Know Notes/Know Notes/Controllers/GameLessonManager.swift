//
//  GameLessonController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class GameLessonManager {
    
    static let manager = GameLessonManager()
    
    var lesson: Lesson = Lesson(instrument: "Grand Piano", noteGroups: .wholeNotes)
    
    func setLesson(lesson: Lesson) {
        self.lesson = lesson
    }

    var lifes: Int = 5
    var score: Int = 0
    
    var sessionNotes: [Note] {
        return lesson.round1Notes
    }
    
    var currentNote: Note?
    
    
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
    
}
