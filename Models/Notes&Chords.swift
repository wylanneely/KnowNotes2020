//
//  Notes&Chords.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/5/20.
//

import Foundation

class Note {
    let name: String
    let id: Int
    let soundPath: String?
    
    
    var isRandomlySelected: Bool = false
    
    init(name: String, id: Int, soundPath: String) {
        self.name = name
        self.id = id
        self.soundPath = soundPath
    }
}

class Chord: Note {
    let type: ChordType?
    init(name: String, id: Int, soundPath: String, type: ChordType) {
        self.type = type
        super.init(name: name, id: id, soundPath: soundPath)
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        if lhs.id == rhs.id && lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
    static func == (lhs: Note, rhs: Chord) -> Bool {
        if lhs.id == rhs.id && lhs.name == rhs.name {
            return true
        } else {
            return false
        }
    }
}

enum NoteType: String {
    case wholeNotes = "Whole"
    case halfNotes = "Halfs"
    case allNotes = "All"
}
enum ChordType: String {
    case major = "Major"
    case minor = "Minor"
}
