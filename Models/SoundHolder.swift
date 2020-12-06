//
//  Instrument.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/24/20.
//

import Foundation


struct SoundHolder {
    
    let type : InstrumentType
    let notes: [Note]
    
     var round1Notes: [Note] {
        if type == .grandPiano {
            return [A_note,B_note,C_note]
        } else if type == .acousticGuitar {
            return [A_Major,B_Major,C_Major]
        } else if type == .violin {
           return [A_violin,B_violin,C_violin]
        } else {
            return [A_sax,B_sax,C_sax]
        }
    }
    
     var round2Notes: [Note] {
        if type == .grandPiano {
            return [A_note,B_note,C_note,D_note,E_note]
        } else if type == .acousticGuitar {
            return [A_Major,B_Major,C_Major,D_Major,E_Major]
        } else if type == .violin {
           return [A_violin,B_violin,C_violin,D_violin,E_violin]
        } else {
            return [A_sax,B_sax,C_sax,D_sax,E_sax]
        }
    }
    
     var round3Notes: [Note] {
        if type == .grandPiano {
            return [A_note,B_note,C_note,D_note,E_note,F_note,G_note]
        } else if type == .acousticGuitar {
            return [A_Major,B_Major,C_Major,D_Major,E_Major,F_Major,G_Major]
        } else if type == .violin {
            return [A_violin,B_violin,C_violin,D_violin,E_violin,F_violin,G_violin]
        } else {
            return [A_sax,B_sax,C_sax,D_sax,E_sax,F_sax,G_sax]
        }
    }
    
    //MARK: Piano Chords

    var grandPianoNotes: [Note] {
        return [A_note,
                B_note,
                C_note,
                D_note,
                E_note,
                F_note,
                G_note]
    }
    
    fileprivate let A_note = Note(name: "A", id: 0, soundPath: "piano_A.wav")
    fileprivate let B_note = Note(name: "B", id: 2, soundPath: "piano_B.wav")
    fileprivate let C_note = Note(name: "C", id: 3, soundPath: "piano_C.wav")
    fileprivate let D_note = Note(name: "D", id: 5, soundPath: "piano_D.wav")
    fileprivate let E_note = Note(name: "E", id: 7, soundPath: "piano_E.wav")
    fileprivate let F_note = Note(name: "F", id: 8, soundPath: "piano_F.wav")
    fileprivate let G_note = Note(name: "G", id: 10, soundPath: "piano_G.wav")
    
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
    
    
    //MARK: Saxaphone
    
    var SaxNotes: [Note] {
        return [A_sax,B_sax,C_sax,D_sax,E_sax,F_sax,G_sax]
    }
    
    fileprivate let A_sax = Note(name: "A", id: 0, soundPath: "sax_a2.wav")
    fileprivate let B_sax = Note(name: "B", id: 1, soundPath: "sax_b2.wav")
    fileprivate let C_sax = Note(name: "C", id: 2, soundPath: "sax_c3.wav")
    fileprivate let D_sax = Note(name: "D", id: 3, soundPath: "sax_d3.wav")
    fileprivate let E_sax = Note(name: "E", id: 4, soundPath: "sax_e3.wav")
    fileprivate let F_sax = Note(name: "F", id: 5, soundPath: "sax_f2.wav")
    fileprivate let G_sax = Note(name: "G", id: 6, soundPath: "sax_g2.wav")
    
    
}


