//
//  Instrument.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/24/20.
//

import Foundation

struct Instrument {
    
    let type : InstrumentType
    let notes: [Note]
    
     var round1Notes: [Note] {
        if type == .grandPiano {
            return [A_note,B_note,C_note]
        } else if type == .acousticGuitar {
            return [A_Major,B_Major,C_Major]
        } else {
           return [A_violin,B_violin,C_violin]
        }
    }
    
     var round2Notes: [Note] {
        if type == .grandPiano {
            return [A_note,B_note,C_note,D_note,E_note]
        } else if type == .acousticGuitar {
            return [A_Major,B_Major,C_Major,D_Major,E_Major]
        } else {
           return [A_violin,B_violin,C_violin,D_violin,E_violin]
        }
    }
    
     var round3Notes: [Note] {
        if type == .grandPiano {
            return [A_note,B_note,C_note,D_note,E_note,F_note,G_note]
        } else if type == .acousticGuitar {
            return [A_Major,B_Major,C_Major,D_Major,E_Major,F_Major,G_Major]
        } else {
            return [A_violin,B_violin,C_violin,D_violin,E_violin,F_violin,G_violin]
        }
    }
    
    //MARK: Acoustic Guitar
    
    var acousticMajorChords: [Note] {
        return [A_Major,B_Major,C_Major,
                D_Major,E_Major,F_Major,G_Major]
    }
    
    fileprivate let A_Major = Note(name: "A", id: 0, soundPath: "AcouGuitar_A_Major.wav")
    fileprivate let B_Major = Note(name: "B", id: 1, soundPath: "AcouGuitar_B_Major.wav")
    fileprivate let C_Major = Note(name: "C", id: 2, soundPath: "AcouGuitar_C_Major.wav")
    fileprivate let D_Major = Note(name: "D", id: 3, soundPath: "AcouGuitar_D_Major.wav")
    fileprivate let E_Major = Note(name: "E", id: 4, soundPath: "AcouGuitar_E_Major.wav")
    fileprivate let F_Major = Note(name: "F", id: 5, soundPath: "AcouGuitar_F_Major.wav")
    fileprivate let G_Major = Note(name: "G", id: 6, soundPath: "AcouGuitar_G_Major.wav")
    
    //MARK: Piano Chords

    var grandPianoNotes: [Note] {
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
    
    fileprivate let A_note = Note(name: "A", id: 0, soundPath: "piano_A.wav")
    fileprivate let Bb_note = Note(name: "Bflat", id: 1)
    fileprivate let B_note = Note(name: "B", id: 2, soundPath: "piano_B.wav")
    fileprivate let C_note = Note(name: "C", id: 3, soundPath: "piano_C.wav")
    fileprivate let Cs_note = Note(name: "Csharp", id: 4)
    fileprivate let D_note = Note(name: "D", id: 5, soundPath: "piano_D.wav")
    fileprivate let Eb_note = Note(name: "Eflat", id: 6)
    fileprivate let E_note = Note(name: "E", id: 7, soundPath: "piano_E.wav")
    fileprivate let F_note = Note(name: "F", id: 8, soundPath: "piano_F.wav")
    fileprivate let Fs_note = Note(name: "Fsharp", id: 9)
    fileprivate let G_note = Note(name: "G", id: 10, soundPath: "piano_G.wav")
    fileprivate let Gs_note = Note(name: "Gsharp", id: 11)
    
    
    //MARK: Violin
    
    var violinNotes: [Note] {
        return [A_violin,B_violin,C_violin,
                D_violin,E_violin,F_violin,G_violin]
    }
    
    fileprivate let A_violin = Note(name: "A", id: 0, soundPath: "violin_A.wav")
    fileprivate let B_violin = Note(name: "B", id: 1, soundPath: "violin_B.wav")
    fileprivate let C_violin = Note(name: "C", id: 2, soundPath: "violin_C.wav")
    fileprivate let D_violin = Note(name: "D", id: 3, soundPath: "violin_D.wav")
    fileprivate let E_violin = Note(name: "E", id: 4, soundPath: "violin_E.wav")
    fileprivate let F_violin = Note(name: "F", id: 5, soundPath: "violin_F.wav")
    fileprivate let G_violin = Note(name: "G", id: 6, soundPath: "violin_G.wav")
    
    
}

enum InstrumentType: String {
    case grandPiano = "Grand Piano"
    case acousticGuitar = "Acoustic Guitar"
    case violin = "Violin"
}
