//
//  Instruments.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/5/20.
//

import Foundation

struct Instruments {
    var grandPiano = GrandPiano()
    var acousticGuitar = AcousticGuitar()
    var violin = Violin()
    var saxaphone = Saxaphone()
}

class Instrument {
    let type : InstrumentType
    init(type: InstrumentType) {
        self.type = type
    }
}

class GrandPiano: Instrument, NoteRounds {
    
    init() {
        super.init(type: .grandPiano)
    }
    
    var round1Notes: [Note] {
        return [A_note,B_note,C_note]
    }
    var round2Notes: [Note] {
        return [A_note,B_note,C_note,D_note,E_note]
    }
    var round3Notes: [Note] {
        return [A_note,B_note,C_note,D_note,E_note,F_note,G_note]
    }
    
    
    func setCustoms(notes:[Note], round:Int) {
        switch round {
        case 1:
            allCustomRound1Notes = notes
            for note in notes {
                if note.isShuffledExtraNote == false {
                    cRound1Notes.append(note)
                }
            }
            
            //TODO:
          //  Session.manager.customInstrument
        case 2:
            allCustomRound2Notes = notes
            for note in notes {
                if note.isShuffledExtraNote == false {
                    cRound2Notes.append(note)
                }
            }
        default:
            allCustomRound3Notes = notes
            for note in notes {
                if note.isShuffledExtraNote == false {
                    cRound3Notes.append(note)
                }
            }
        }
       
    }
    
    var cRound1Notes: [Note] = []
    
    var allCustomRound1Notes: [Note] = []
    
    func refreshCustomRound1Notes() {
        var gameRoundNotes = allCustomRound1Notes
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        cRound1Notes = [note_1!,note_2!,note_3!]
    }
    
    var cRound2Notes: [Note] = []
     var allCustomRound2Notes: [Note] = []
    
    func refreshCustomRound2Notes() {
        var gameRoundNotes = allCustomRound2Notes
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_3!)
        let note_4 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_4!)
        let note_5 = gameRoundNotes.randomElement()
        cRound2Notes = [note_1!,note_2!,note_3!,note_4!,note_5!]
    }
    var cRound3Notes: [Note] = []
     var allCustomRound3Notes: [Note] = []
    func refreshCustomRound3Notes() {
        var gameRoundNotes = allCustomRound1Notes
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_3!)
        let note_4 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_4!)
        let note_5 = gameRoundNotes.randomElement()
        
        gameRoundNotes.remove(object: note_5!)
        let note_6 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_6!)
        let note_7 = gameRoundNotes.randomElement()
        cRound3Notes = [note_1!,note_2!,note_3!,note_4!,note_5!,note_6!,note_7!]
    }
    
   lazy var noteDictionary: [Int:Note] =
    [0:A_note,1:Bb_note,2:B_note,
    3:C_note,4:Cs_note,5:D_note,
    6:Eb_note,7:E_note,8:F_note,
    9:Fs_note,10:G_note,11:Gs_note]
    
    var sharpsFlatsRound1: [Note] {
        var gameRoundNotes: [Note] = [A_note,Bb_note,B_note,C_note,Cs_note]
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        return [note_1!,note_2!,note_3!]
    }
    var sharpsFlatsRound2: [Note] {
        var gameRoundNotes: [Note] = [A_note,Bb_note,B_note,C_note,Cs_note,D_note,Eb_note,E_note]
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_3!)
        let note_4 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_4!)
        let note_5 = gameRoundNotes.randomElement()
        return [note_1!,note_2!,note_3!,note_4!,note_5!]
    }
    var sharpsFlatsRound3: [Note] {
        var gameRoundNotes: [Note] = [A_note,Bb_note,B_note,
                                      C_note,Cs_note,D_note,
                                      Eb_note,E_note,F_note,
                                      Fs_note,G_note,Gs_note]
        
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_3!)
        let note_4 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_4!)
        let note_5 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_5!)
        let note_6 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_6!)
        let note_7 = gameRoundNotes.randomElement()
        return [note_1!,note_2!,note_3!,note_4!,note_5!,note_6!,note_7!]
    }
    
    //MARK: Notes
    
    fileprivate let A_note = Note(name: "A", id: 0, soundPath: "piano_A.wav")
    fileprivate let Bb_note = Note(name: "B♭", id: 1, soundPath: "piano_A#.wav")
    fileprivate let B_note = Note(name: "B", id: 2, soundPath: "piano_B.wav")
    fileprivate let C_note = Note(name: "C", id: 3, soundPath: "piano_C.wav")
    fileprivate let Cs_note = Note(name: "C#", id: 4, soundPath: "piano_C#.wav")
    fileprivate let D_note = Note(name: "D", id: 5, soundPath: "piano_D.wav")
    fileprivate let Eb_note = Note(name: "E♭", id: 6, soundPath: "piano_D#.wav")
    fileprivate let E_note = Note(name: "E", id: 7, soundPath: "piano_E.wav")
    fileprivate let F_note = Note(name: "F", id: 8, soundPath: "piano_F.wav")
    fileprivate let Fs_note = Note(name: "F#", id: 9,  soundPath: "piano_F#.wav")
    fileprivate let G_note = Note(name: "G", id: 10, soundPath: "piano_G.wav")
    fileprivate let Gs_note = Note(name: "G#", id: 11, soundPath: "piano_G#.wav")
}

class AcousticGuitar: Instrument, NoteRounds {
    
    init() {
        super.init(type: .acousticGuitar)
    }
    var includesMinors: Bool = false
    
    var round1Notes: [Note] {
        if includesMinors {
          return  [A_Major,B_Major,C_Major,A_Minor,B_Minor,C_Minor]
        } else {
        return [A_Major,B_Major,C_Major]
        }
    }
    var round2Notes: [Note] {
        if includesMinors {
            return [A_Major,B_Major,C_Major,D_Major,E_Major,A_Minor,B_Minor,C_Minor,D_Minor,E_Minor]
        } else {
        return [A_Major,B_Major,C_Major,D_Major,E_Major]
        }
    }
    var round3Notes: [Note] {
        if includesMinors {
          return  [A_Major,B_Major,C_Major,D_Major,
                 E_Major,F_Major,G_Major,A_Minor,
                 B_Minor,C_Minor,D_Minor,E_Minor,
                 F_Minor,G_Minor]
        } else {
        return [A_Major,B_Major,C_Major,D_Major,E_Major,F_Major,G_Major]
        }
    }
    
    var minorMajorChordsRound1: [Note] {
        var gameRoundNotes: [Note] = [A_Major,B_Major,C_Major,A_Minor,B_Minor,C_Minor]
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        return [note_1!,note_2!,note_3!]
    }
    
    var minorMajorChordsRound2: [Note] {
        var gameRoundNotes: [Note] = [A_Major,B_Major,C_Major,D_Major,E_Major,A_Minor,B_Minor,C_Minor,D_Minor,E_Minor]
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_3!)
        let note_4 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_4!)
        let note_5 = gameRoundNotes.randomElement()
        return [note_1!,note_2!,note_3!,note_4!,note_5!]
    }
    
    var minorChordsRound3: [Note] {
        var gameRoundNotes: [Note] = [A_Major,B_Major,C_Major,D_Major,
             E_Major,F_Major,G_Major,A_Minor,
             B_Minor,C_Minor,D_Minor,E_Minor,
             F_Minor,G_Minor]
        
        let note_1 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_1!)
        let note_2 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_2!)
        let note_3 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_3!)
        let note_4 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_4!)
        let note_5 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_5!)
        let note_6 = gameRoundNotes.randomElement()
        gameRoundNotes.remove(object: note_6!)
        let note_7 = gameRoundNotes.randomElement()
        return [note_1!,note_2!,note_3!,note_4!,note_5!,note_6!,note_7!]
    }
    
    //MARK: Chords
    
    fileprivate let A_Minor = Note(name: "Am", id: 0, soundPath: "AcouGuitar_A_Minor.wav")
    fileprivate let B_Minor = Note(name: "Bm", id: 1, soundPath: "AcouGuitar_B_Minor.wav")
    fileprivate let C_Minor = Note(name: "Cm", id: 2, soundPath: "AcouGuitar_C_Minor.wav")
    fileprivate let D_Minor = Note(name: "Dm", id: 3, soundPath: "AcouGuitar_D_Minor.wav")
    fileprivate let E_Minor = Note(name: "Em", id: 4, soundPath: "AcouGuitar_E_Minor.wav")
    fileprivate let F_Minor = Note(name: "Fm", id: 5, soundPath: "AcouGuitar_F_Minor.wav")
    fileprivate let G_Minor = Note(name: "Gm", id: 6, soundPath: "AcouGuitar_G_Minor.wav")
    
    fileprivate let A_Major = Note(name: "A", id: 7, soundPath: "AcouGuitar_A_Major.wav")
    fileprivate let B_Major = Note(name: "B", id: 8, soundPath: "AcouGuitar_B_Major.wav")
    fileprivate let C_Major = Note(name: "C", id: 9, soundPath: "AcouGuitar_C_Major.wav")
    fileprivate let D_Major = Note(name: "D", id: 10, soundPath: "AcouGuitar_D_Major.wav")
    fileprivate let E_Major = Note(name: "E", id: 11, soundPath: "AcouGuitar_E_Major.wav")
    fileprivate let F_Major = Note(name: "F", id: 12, soundPath: "AcouGuitar_F_Major.wav")
    fileprivate let G_Major = Note(name: "G", id: 13, soundPath: "AcouGuitar_G_Major.wav")
}

class Violin: Instrument, NoteRounds {
    
    init() {
        super.init(type: .violin)
    }
    var round1Notes: [Note] {
        return [A_violin,B_violin,C_violin]
    }
    var round2Notes: [Note] {
        return [A_violin,B_violin,C_violin,D_violin,E_violin]
    }
    var round3Notes: [Note] {
        return [A_violin,B_violin,C_violin,D_violin,
                E_violin,F_violin,G_violin]
    }
    
    //MARK: Notes

    fileprivate let A_violin = Note(name: "A", id: 0, soundPath: "violin_A.wav")
    fileprivate let B_violin = Note(name: "B", id: 1, soundPath: "violin_B.wav")
    fileprivate let C_violin = Note(name: "C", id: 2, soundPath: "violin_C.wav")
    fileprivate let D_violin = Note(name: "D", id: 3, soundPath: "violin_D.wav")
    fileprivate let E_violin = Note(name: "E", id: 4, soundPath: "violin_E.wav")
    fileprivate let F_violin = Note(name: "F", id: 5, soundPath: "violin_F.wav")
    fileprivate let G_violin = Note(name: "G", id: 6, soundPath: "violin_G.wav")
}

class Saxaphone: Instrument, NoteRounds {
    init() {
        super.init(type: .saxaphone)
    }
    var round1Notes: [Note] {
        return [A_sax,B_sax,C_sax]
    }
    var round2Notes: [Note] {
        return [A_sax,B_sax,C_sax,D_sax,E_sax]
    }
    var round3Notes: [Note] {
        return  [A_sax,B_sax,C_sax,D_sax,E_sax,F_sax,G_sax]
    }
    
    fileprivate let A_sax = Note(name: "A", id: 0, soundPath: "sax_a2.wav")
    fileprivate let B_sax = Note(name: "B", id: 1, soundPath: "sax_b2.wav")
    fileprivate let C_sax = Note(name: "C", id: 2, soundPath: "sax_c3.wav")
    fileprivate let D_sax = Note(name: "D", id: 3, soundPath: "sax_d3.wav")
    fileprivate let E_sax = Note(name: "E", id: 4, soundPath: "sax_e3.wav")
    fileprivate let F_sax = Note(name: "F", id: 5, soundPath: "sax_f2.wav")
    fileprivate let G_sax = Note(name: "G", id: 6, soundPath: "sax_g2.wav")
}

protocol NoteRounds {
    var round1Notes: [Note] { get }
    var round2Notes: [Note] { get }
    var round3Notes: [Note] { get }
}

enum InstrumentType: String {
    case grandPiano = "Grand Piano"
    case acousticGuitar = "Acoustic Guitar"
    case violin = "Violin"
    case saxaphone = "Saxaphone"
}

