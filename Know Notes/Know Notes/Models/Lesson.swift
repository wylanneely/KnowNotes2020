//
//  GameLesson.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class Lesson {
    
    
    let instrumentName: String
    var noteGroup: NoteGroups
    var  lessonNotes: [Note] = []
    
    init(instrument: String, noteGroups: NoteGroups) {
        self.instrumentName = instrument
        self.noteGroup = noteGroups
        switch noteGroup {
        case .allNotes:
            lessonNotes = allNotes
        case .wholeNotes:
            lessonNotes = wholeNotes
        case .halfNotes:
            lessonNotes = halfNotes
        }
    }
    
    lazy var round1Notes: [Note] = [A_note,B_note,C_note]
    lazy var round2Notes: [Note] = [A_note,B_note,C_note,D_note,E_note]
    lazy var round3Notes: [Note] = [A_note,B_note,C_note,D_note,E_note,F_note,G_note]
    
    
    
    
    //MARK: Instrument Notes
    
    let A_note = Note(name: "A", id: 0)
    let Bb_note = Note(name: "Bflat", id: 1)
    let B_note = Note(name: "B", id: 2)
    let C_note = Note(name: "C", id: 3)
    let Cs_note = Note(name: "Csharp", id: 4)
    let D_note = Note(name: "D", id: 5)
    let Eb_note = Note(name: "Eflat", id: 6)
    let E_note = Note(name: "E", id: 7)
    let F_note = Note(name: "F", id: 8)
    let Fs_note = Note(name: "Fsharp", id: 9)
    let G_note = Note(name: "G", id: 10)
    let Gs_note = Note(name: "Gsharp", id: 11)

    
    private var wholeNotes: [Note] {
        return [A_note,
                B_note,
                C_note,
                D_note,
                E_note,
                F_note,
                G_note]
    }
    
    private var allNotes: [Note] {
        return [A_note,
                Bb_note,
                Cs_note,
                Eb_note,
                Fs_note,
                Gs_note,
                B_note,
                C_note,
                D_note,
                E_note,
                F_note,
                G_note]
    }
    private var halfNotes: [Note] {
        return [Bb_note,
                Cs_note,
                Eb_note,
                Fs_note,
                Gs_note]
    }



}

enum NoteGroups: String {
    case wholeNotes = "Whole"
    case halfNotes = "Halfs"
    case allNotes = "All"
}


struct Note {
    let name: String
    let id: Int
}
