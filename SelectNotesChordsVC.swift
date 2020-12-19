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
        assignsGestureRecognizersToLabels()
    }
   
    
    //MARK: Properties
    
    var roundNumber: Int = 1
    let instrument = Session.manager.customInstrument
    let piano = GrandPiano()
    var roundNotes: [Note] = []

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
                    self.roundNotes.append(note)
                }
            }
            for noteTag in selectedShuffledNoteTags {
                if let note = piano.noteDictionary[noteTag] {
                    note.isShuffledExtraNote = true
                    self.roundNotes.append(note)
                }
            }
        }
    }

    //MARK: Setup
    @IBOutlet weak var roundStack: UIStackView!
    func setUP(){
        
        
        startNotesButton.setTitleColor(.white, for: .selected)
        shuffledNotesButton.setTitleColor(.white, for: .selected)
        roundStack.layer.cornerRadius = 12
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40
                                                      , weight: .bold, scale: .large)
         let largeBoldDoc = UIImage(systemName: "xmark.circle.fill", withConfiguration: largeConfig)
        exitButton.setImage(largeBoldDoc, for: .normal)
        selectView.layer.cornerRadius = 10
        startNotesButton.isSelected = true
        IsSelectingStart = true
        startNotesButton.layer.borderColor = UIColor.black.cgColor
        startNotesButton.layer.borderWidth = 2
        shuffledNotesButton.layer.borderColor = UIColor.white.cgColor
        shuffledNotesButton.layer.borderWidth = 2
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
        for button in computedNoteButtons {
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
            selectedStartNoteTags = []
            selectedShuffledNoteTags = []
            
            roundLabel.textColor = UIColor.lightGray
            round2Label.textColor = UIColor.white
            sNotesTapped(self)
        }
        
        if round == 3 {
            roundNumber = 3
            maxNumberOfRegularNotes = 7
            maxNumberOfShuffledNotes = 5
            roundLabel.textColor = UIColor.lightGray
            round2Label.textColor = UIColor.lightGray
            round3Label.textColor = UIColor.white
            sNotesTapped(self)
        }
    }
    
    fileprivate func setNextRound() {
        
        if startNumber == maxNumberOfRegularNotes {
            switch roundNumber {
            case 1:
                saveNotes(notes: self.roundNotes, round: 1)
                self.setMaxNumbersAndTags(round: 2)
                sNotesTapped(self)
                roundNotes = []
                updateButtons()
            case 2:
                saveNotes(notes: self.roundNotes, round: 2)
                self.setMaxNumbersAndTags(round: 3)
                sNotesTapped(self)
                roundNotes = []
                updateButtons()
            default:
                saveNotes(notes: self.roundNotes, round: 3)
                self.performSegue(withIdentifier: "cRound1", sender: self)
            }
        }
    }

    //MARK: Update
    
    private func updateCounts(){
        DispatchQueue.main.async {
        self.startnumberLabel.text = "\(self.startNumber)/\(self.maxNumberOfRegularNotes)"
        self.shufflenumberLabel.text = "\(self.shuffleNumber)/\(self.maxNumberOfShuffledNotes)"
        }
            if  (startNumber == maxNumberOfRegularNotes) {
                self.shuffledNotesTapped(self)
                if (shuffleNumber == maxNumberOfShuffledNotes){
                startButton.pulse()
            }
        }
    }
    
    func updateSelectedSharpsFlats(_ tag: Int){
        for label in sharpFlatLabels {
            if label.tag == tag {
                label.textColor = UIColor.white
            }
        }
    }
    func updateShuffledSharpsFlats(_ tag: Int){
        for label in sharpFlatLabels {
            if label.tag == tag {
                label.textColor = UIColor.black
            }
        }
    }
    
    func updateButtons(){
        for button in computedNoteButtons {
            if selectedStartNoteTags.contains(button.tag){
                updateSelectedSharpsFlats(button.tag)
                DispatchQueue.main.async {
                    button.isSelected = true
                    button.layer.borderColor = UIColor.discoDayGReen.cgColor
                    button.setTitleShadowColor(.discoDayGReen, for: .selected)
                    button.backgroundColor = UIColor.discoDayGReen
                    button.setTitleColor(.white, for: .normal)
           }
            } else if selectedShuffledNoteTags.contains(button.tag){
                updateShuffledSharpsFlats(button.tag)
                DispatchQueue.main.async {
                button.isSelected = true
                button.layer.borderColor = UIColor.midnightPurps.cgColor
                button.setTitleShadowColor(.midnightPurps, for: .selected)
                button.backgroundColor = UIColor.midnightPurps
                }
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
    
    
    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var round2Label: UILabel!
    @IBOutlet weak var round3Label: UILabel!
    @IBOutlet weak var startnumberLabel: UILabel!
    @IBOutlet weak var shufflenumberLabel: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startNotesButton: UIButton!
    @IBOutlet weak var shuffledNotesButton: UIButton!
    @IBOutlet weak var note_A: UIButton!
    @IBOutlet weak var note_Bb: UIButton!
    @IBOutlet weak var flatBbLabel: UILabel!
    @IBOutlet weak var note_B: UIButton!
    @IBOutlet weak var note_C: UIButton!
    @IBOutlet weak var note_Cs: UIButton!
    @IBOutlet weak var sharpCsLabel: UILabel!
    @IBOutlet weak var note_D: UIButton!
    @IBOutlet weak var note_E: UIButton!
    @IBOutlet weak var note_Eb: UIButton!
    @IBOutlet weak var flatEbLabel: UILabel!
    @IBOutlet weak var note_F: UIButton!
    @IBOutlet weak var note_Fs: UIButton!
    @IBOutlet weak var sarpFsLabel: UILabel!
    @IBOutlet weak var note_G: UIButton!
    @IBOutlet weak var note_Gs: UIButton!
    @IBOutlet weak var sharpGsLabel: UILabel!
    
    


    lazy var sharpFlatLabels: [UILabel] = [sharpGsLabel,sarpFsLabel,flatEbLabel,sharpCsLabel,flatBbLabel]

    
    var computedNoteButtons: [UIButton] {
      return [note_A,note_Bb,note_B,note_C,note_Cs,note_D,note_E,note_Eb,note_F,note_Fs,note_G,note_Gs] }
    
    func assignsGestureRecognizersToLabels(){
        roundLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.label1Tapped(sender:)))
        roundLabel.addGestureRecognizer(tapGesture)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.label2Tapped(sender:)))
        roundLabel.addGestureRecognizer(tapGesture2)
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.label3Tapped(sender:)))
        roundLabel.addGestureRecognizer(tapGesture3)
    }
    
    
    
    @objc func label1Tapped(sender: UITapGestureRecognizer) {
        let notes = piano.allCustomRound1Notes
        self.roundNotes = notes
        updateButtons()
        roundLabel.textColor = UIColor.white
        round2Label.textColor = UIColor.lightGray
        round3Label.textColor = UIColor.lightGray
    }
    @objc func label2Tapped(sender: UITapGestureRecognizer) {
        let notes = piano.allCustomRound2Notes
        self.roundNotes = notes
        updateButtons()
        roundLabel.textColor = UIColor.lightGray
        round2Label.textColor = UIColor.white
        round3Label.textColor = UIColor.lightGray
    }
    @objc func label3Tapped(sender: UITapGestureRecognizer) {
        let notes = piano.allCustomRound3Notes
        self.roundNotes = notes
        updateButtons()
        roundLabel.textColor = UIColor.lightGray
        round2Label.textColor = UIColor.lightGray
        round3Label.textColor = UIColor.white
        
    }
    
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
            piano.setCustoms(notes: notes, round: round)
            type.setCustoms(notes: notes, round: round)
        }
        if let type = Session.manager.customInstrument as? AcousticGuitar {
            
        }
        
    }
    
    @IBAction func sNotesTapped(_ sender: Any) {
        startnumberLabel.textColor = UIColor.discoDayGReen
        shufflenumberLabel.textColor = UIColor.white
        shuffledNotesButton.isSelected = false
        startNotesButton.isSelected = true
        IsSelectingStart = true
        startNotesButton.layer.borderColor = UIColor.black.cgColor
        startNotesButton.layer.borderWidth = 2
        shuffledNotesButton.layer.borderColor = UIColor.white.cgColor
        shuffledNotesButton.layer.borderWidth = 2
    }
    
    @IBAction func shuffledNotesTapped(_ sender: Any) {
            startnumberLabel.textColor = UIColor.white
            shufflenumberLabel.textColor = UIColor.midnightPurps
        shuffledNotesButton.isSelected = true
        startNotesButton.isSelected = false
        IsSelectingStart = false
        startNotesButton.layer.borderColor = UIColor.white.cgColor
        startNotesButton.layer.borderWidth = 2
        shuffledNotesButton.layer.borderColor = UIColor.black.cgColor
        shuffledNotesButton.layer.borderWidth = 2
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
