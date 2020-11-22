//
//  GameLesson.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import Foundation


class Lesson {
    
    let instrument: Instrument
    var noteGroup: NoteGroups
    var  lessonNotes: [Note] = []
    
    init(instrument: Instrument, noteGroups: NoteGroups) {
        self.instrument = instrument
        self.noteGroup = noteGroups
    }
    
    lazy var round1Notes: [Note] = instrument.round1Notes
    lazy var round2Notes: [Note] = instrument.round2Notes
    lazy var round3Notes: [Note] = instrument.round3Notes
}

enum NoteGroups: String {
    case wholeNotes = "Whole"
    case halfNotes = "Halfs"
    case allNotes = "All"
}

struct Note {
    let name: String
    let id: Int
    var soundPath: String?
}
