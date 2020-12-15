//
//  SelectNotesChordsVC.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/14/20.
//

import Foundation

import UIKit

class SelectNotesChordsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
    }
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var round2Label: UILabel!
    @IBOutlet weak var round3Label: UILabel!

    
    //MARK: Properties
    
    var roundNumber: Int = 1
    let instrument = Session.manager.customInstrument
    var notes: [Note] = []
    var IsSelectingStart: Bool = true
    var selectedStartNoteTags: [Int] = []
    var selectedShuffledNoteTags: [Int] = []
    var startNumber: Int {
        selectedStartNoteTags.count
    }
    var shuffleNumber: Int {
        selectedShuffledNoteTags.count
    }
    var maxNumberOfRegularNotes: Int = 3
    var maxNumberOfShuffledNotes: Int = 3
    
    func createNotes(){
        if let piano = instrument as? GrandPiano {
            for noteTag in selectedStartNoteTags {
                if let note = piano.noteDictionary[noteTag] {
                    self.notes.append(note)
                }
            }
            for noteTag in selectedShuffledNoteTags {
                if let note = piano.noteDictionary[noteTag] {
                    note.isShuffledExtraNote = true
                    self.notes.append(note)
                }
            }
        }
    }

    //MARK: Setup
    
    func setUP(){
        selectView.layer.cornerRadius = 10
        startNotes.isSelected = true
        IsSelectingStart = true
        startNotes.layer.borderColor = UIColor.black.cgColor
        startNotes.layer.borderWidth = 2
        shuffledNotes.layer.borderColor = UIColor.white.cgColor
        shuffledNotes.layer.borderWidth = 2
        note_A.layer.cornerRadius = 10
        note_A.layer.borderColor = UIColor.white.cgColor
        note_A.layer.borderWidth = 2
        note_Bb.layer.cornerRadius = 10
        note_Bb.layer.borderColor = UIColor.white.cgColor
        note_Bb.layer.borderWidth = 2
        note_B.layer.borderWidth = 2
        note_B.layer.cornerRadius = 10
        note_B.layer.borderColor = UIColor.white.cgColor
        note_C.layer.borderWidth = 2
        note_C.layer.cornerRadius = 10
        note_C.layer.borderColor = UIColor.white.cgColor
        note_Cs.layer.borderWidth = 2
        note_Cs.layer.cornerRadius = 10
        note_Cs.layer.borderColor = UIColor.white.cgColor
        note_D.layer.borderWidth = 2
        note_D.layer.cornerRadius = 10
        note_D.layer.borderColor = UIColor.white.cgColor
        note_E.layer.borderWidth = 2
        note_E.layer.cornerRadius = 10
        note_E.layer.borderColor = UIColor.white.cgColor
        note_Eb.layer.borderWidth = 2
        note_Eb.layer.cornerRadius = 10
        note_Eb.layer.borderColor = UIColor.white.cgColor
        note_F.layer.borderWidth = 2
        note_F.layer.cornerRadius = 10
        note_F.layer.borderColor = UIColor.white.cgColor
        note_Fs.layer.borderWidth = 2
        note_Fs.layer.cornerRadius = 10
        note_Fs.layer.borderColor = UIColor.white.cgColor
        note_G.layer.borderWidth = 2
        note_G.layer.cornerRadius = 10
        note_G.layer.borderColor = UIColor.white.cgColor
        note_Gs.layer.borderWidth = 2
        note_Gs.layer.cornerRadius = 10
        note_Gs.layer.borderColor = UIColor.white.cgColor
        startButton.layer.borderWidth = 2
        startButton.layer.cornerRadius = 10
        startButton.layer.borderColor = UIColor.white.cgColor
        updateButtons()
    }
    
    func setUpSelectedShuffleStartNotes(){
        for button in noteButtons {
            if selectedStartNoteTags.contains(button.tag){
                button.isSelected = true
                button.layer.borderColor = UIColor.discoDayGReen.cgColor
            }
            if selectedShuffledNoteTags.contains(button.tag){
                button.isSelected = false
                button.layer.borderColor = UIColor.middlePurple.cgColor
            }
        }
    }
    
    func setMaxNumbersAndTags(round:Int ) {
        if round == 1 {
            maxNumberOfRegularNotes = 3
            maxNumberOfShuffledNotes = 3
        }
        if round == 2 {
            roundNumber = 2
            maxNumberOfRegularNotes = 5
            maxNumberOfShuffledNotes = 4
            roundLabel.textColor = UIColor.lightGray
            round2Label.textColor = UIColor.white
            selectedStartNoteTags = []
            selectedShuffledNoteTags = []
            sNotesTapped(self)
        }
        
        if round == 3 {
            roundNumber = 3
            maxNumberOfRegularNotes = 7
            maxNumberOfShuffledNotes = 5
            roundLabel.textColor = UIColor.lightGray
            round2Label.textColor = UIColor.lightGray
            round3Label.textColor = UIColor.white
            selectedStartNoteTags = []
            selectedShuffledNoteTags = []
            sNotesTapped(self)
        }
    }
    
    fileprivate func setNextRound() {
        if startNumber == maxNumberOfRegularNotes {
            switch roundNumber {
            case 1:
                saveNotes(notes: self.notes, round: 1)
                self.setMaxNumbersAndTags(round: 2)
            case 2:
                saveNotes(notes: self.notes, round: 2)
                self.setMaxNumbersAndTags(round: 3)
            default:
                saveNotes(notes: self.notes, round: 3)
                self.performSegue(withIdentifier: "cRound1", sender: self)
            }
        }
    }

    //MARK: Update
    
    private func updateCounts(){
        DispatchQueue.main.async {
        self.startnumberLabel.text = "Start Notes: \(self.startNumber)/\(self.maxNumberOfRegularNotes)"
        self.shufflenumberLabel.text = "Shuffle Notes: \(self.shuffleNumber)/\(self.maxNumberOfShuffledNotes)"
        }
            if  (startNumber == maxNumberOfRegularNotes) {
                self.shuffledNotesTapped(self)
                if (shuffleNumber == maxNumberOfShuffledNotes){
                startButton.pulse()
            }
        }
    }

    func updateButtons(){
        for button in computedNoteButtons {
            if selectedStartNoteTags.contains(button.tag){
                DispatchQueue.main.async {
                    button.isSelected = true
                    button.layer.borderColor = UIColor.discoDayGReen.cgColor
                    button.setTitleShadowColor(.discoDayGReen, for: .selected)
                }
            } else if selectedShuffledNoteTags.contains(button.tag){
                button.isSelected = true
                button.layer.borderColor = UIColor.midnightPurps.cgColor
                button.setTitleShadowColor(.midnightPurps, for: .selected)
            } else  {
                DispatchQueue.main.async {
                    button.isSelected = false
                    button.layer.borderColor = UIColor.white.cgColor
                }
            }
            updateCounts()
        }
    }
    
    func updateShuffleButtons(){
        for button in computedNoteButtons {
            if  selectedShuffledNoteTags.contains(button.tag){
                button.isSelected = true
                button.layer.borderColor = UIColor.midnightPurps.cgColor
                button.setTitleShadowColor(.midnightPurps, for: .selected)
            } else {
                button.isSelected = false
                button.layer.borderColor = UIColor.white.cgColor
            }
        }
    }

    func updateStartNotesWith(button:UIButton){
        if selectedStartNoteTags.contains(button.tag) {
            selectedStartNoteTags.remove(object: button.tag)
            updateButtons()
            return
        }
        if selectedStartNoteTags.count < maxNumberOfRegularNotes {
            selectedStartNoteTags.append(button.tag)
            updateButtons()
        } else {
            return
        }
    }
    
    func updateShuffleNotesWith(button:UIButton){
        if selectedShuffledNoteTags.count < maxNumberOfShuffledNotes {
        selectedShuffledNoteTags.append(button.tag)
        updateButtons()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var startnumberLabel: UILabel!
    @IBOutlet weak var shufflenumberLabel: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startNotes: UIButton!
    @IBOutlet weak var note_A: UIButton!
    @IBOutlet weak var shuffledNotes: UIButton!
    @IBOutlet weak var note_Bb: UIButton!
    @IBOutlet weak var note_B: UIButton!
    @IBOutlet weak var note_C: UIButton!
    @IBOutlet weak var note_Cs: UIButton!
    @IBOutlet weak var note_D: UIButton!
    @IBOutlet weak var note_E: UIButton!
    @IBOutlet weak var note_Eb: UIButton!
    @IBOutlet weak var note_F: UIButton!
    @IBOutlet weak var note_Fs: UIButton!
    @IBOutlet weak var note_G: UIButton!
    @IBOutlet weak var note_Gs: UIButton!
    
    lazy var noteButtons: [UIButton] =
        [note_A,note_Bb,note_B,note_C,note_Cs,note_D,note_E,note_Eb,note_F,note_Fs,note_G,note_Gs]
    
    var computedNoteButtons: [UIButton] {
      return [note_A,note_Bb,note_B,note_C,note_Cs,note_D,note_E,note_Eb,note_F,note_Fs,note_G,note_Gs] }
    // MARK: - Actions
    
    @IBAction func note_ASelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_A.tag) {
                selectedStartNoteTags.remove(at: note_A.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_A.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_A.tag) {
                selectedShuffledNoteTags.remove(at: note_A.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_A)
                return
            }
        }
    }
    @IBAction func note_BbSelected(_ sender: Any) {
        
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_Bb.tag) {
                selectedStartNoteTags.remove(object: note_Bb.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_Bb.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_Bb.tag) {
                selectedShuffledNoteTags.remove(object: note_Bb.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_Bb)
                return
            }
        }
    }
    @IBAction func note_BSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_B.tag) {
                selectedStartNoteTags.remove(object: note_B.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_B.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_B.tag) {
                selectedShuffledNoteTags.remove(object: note_B.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_B)
                return
            }
        }
    }
    @IBAction func note_CSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_C.tag) {
                selectedStartNoteTags.remove(object: note_C.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_C.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_C.tag) {
                selectedShuffledNoteTags.remove(object: note_C.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_C)
                return
            }
        }
    }
    @IBAction func note_CsSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_Cs.tag) {
                selectedStartNoteTags.remove(object: note_Cs.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_Cs.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_Cs.tag) {
                selectedShuffledNoteTags.remove(object: note_Cs.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_Cs)
                return
            }
        }
    }
    @IBAction func note_DSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_D.tag) {
                selectedStartNoteTags.remove(object: note_D.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_D.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_D.tag) {
               selectedShuffledNoteTags.remove(object: note_D.tag)
                
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_D)
                return
            }
        }
    }
    @IBAction func note_ESelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_E.tag) {
                selectedStartNoteTags.remove(object: note_E.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_E.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_E.tag) {
                selectedShuffledNoteTags.remove(object: note_E.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_E)
                return
            }
        }
    }
    @IBAction func note_EbSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_Eb.tag) {
                selectedStartNoteTags.remove(object: note_Eb.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_Eb.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_Eb.tag) {
                selectedShuffledNoteTags.remove(object: note_Eb.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_Eb)
                return
            }
        }
    }
    @IBAction func note_FSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_F.tag) {
                selectedStartNoteTags.remove(object: note_F.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_F.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_F.tag) {
                selectedShuffledNoteTags.remove(object: note_F.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_F)
                return
            }
        }
    }
    @IBAction func note_AFsSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_Fs.tag) {
                selectedStartNoteTags.remove(object: note_Fs.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_Fs.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_Fs.tag) {
                selectedShuffledNoteTags.remove(object: note_Fs.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_Fs)
                return
            }
        }
    }
    @IBAction func note_GSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_G.tag) {
                selectedStartNoteTags.remove(object: note_G.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_G.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_G.tag) {
                selectedShuffledNoteTags.remove(object: note_G.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_G)
                return
            }
        }
    }
    @IBAction func note_GsSelected(_ sender: Any) {
        if IsSelectingStart {
            if selectedStartNoteTags.contains(note_Gs.tag) {
                selectedStartNoteTags.remove(object: note_Gs.tag)
                updateButtons()
                return
            } else if selectedStartNoteTags.count < maxNumberOfRegularNotes  {
                selectedStartNoteTags.append(note_Gs.tag)
                updateButtons()
                return
            }
        } else {
            if selectedShuffledNoteTags.contains(note_Gs.tag) {
                selectedShuffledNoteTags.remove(object: note_Gs.tag)
                updateButtons()
                return
            } else {
                updateShuffleNotesWith(button: note_Gs)
                return
            }
        }
    }
    

    
    @IBAction func startTapped(_ sender: Any) {
        self.createNotes()
        setNextRound()
    }
    
    
    
    func saveNotes(notes: [Note], round: Int){
        if let type = Session.manager.customInstrument as? GrandPiano {
            type.setCustoms(notes: notes, round: round)
        }
        if let type = Session.manager.customInstrument as? AcousticGuitar {
            
        }
       
    }
    
    @IBAction func sNotesTapped(_ sender: Any) {
        shuffledNotes.isSelected = false
            startNotes.isSelected = true
            IsSelectingStart = true
            startNotes.layer.borderColor = UIColor.black.cgColor
            startNotes.layer.borderWidth = 2
            shuffledNotes.layer.borderColor = UIColor.white.cgColor
            shuffledNotes.layer.borderWidth = 2
    }
    @IBAction func shuffledNotesTapped(_ sender: Any) {
    shuffledNotes.isSelected = true
        startNotes.isSelected = false
        IsSelectingStart = false
        startNotes.layer.borderColor = UIColor.white.cgColor
        startNotes.layer.borderWidth = 2
        shuffledNotes.layer.borderColor = UIColor.black.cgColor
        shuffledNotes.layer.borderWidth = 2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let VC = presentingViewController as? KnownPlayerInstrumentNotesTableViewController {
            
        }
       
    }
}

extension UIButton {
    static var isShuffledNote: Bool = false
}
