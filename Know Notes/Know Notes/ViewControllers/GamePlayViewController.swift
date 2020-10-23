//
//  GamePlayViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/19/20.
//

import UIKit

class GamePlayViewController: UIViewController {

    //Example to display buttons
    var gameLesson: Lesson = Lesson(instrument: "Grand Piano", noteGroups: .wholeNotes)
    
    let gameController = GameLessonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideAllButtonsViews()
        setPlayableNoteButtons(with: gameLesson.round1Notes)
    }
    
    
    func setUsedNoteButtons(){
        switch gameLesson.noteGroup {
        case .wholeNotes:
            noteBflatASharpButton.isHidden = true
            noteCsharpDflatButton.isHidden = true
            noteEflatButton.isHidden = true
            noteFsharpButton.isHidden = true
            noteGsharpButton.isHidden = true
            bBView.isHidden = true
            cSView.isHidden = true
            eBView.isHidden = true
            fSView.isHidden = true
            gSView.isHidden = true
        case .allNotes:
            noteAButton.isHidden = false
        case .halfNotes:
            noteAButton.isHidden = true
            noteBButton.isHidden = true
            noteCButton.isHidden = true
            noteDButton.isHidden = true
            noteEButton.isHidden = true
            noteFButton.isHidden = true
            noteGButton.isHidden = true
            aView.isHidden = true
            bView.isHidden = true
            cView.isHidden = true
            dView.isHidden = true
            eView.isHidden = true
            fView.isHidden = true
            GView.isHidden = true
        }    
    }
    
    var currentNote: Note?
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
           let nextNote = gameController.getNextNote()
        self.currentNote = nextNote
    }
    
    
    
    
    //MARK: Properties

    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var bBView: UIView!
    @IBOutlet weak var bView: UIView!
    @IBOutlet weak var cView: UIView!
    @IBOutlet weak var cSView: UIView!
    @IBOutlet weak var dView: UIView!
    @IBOutlet weak var eBView: UIView!
    @IBOutlet weak var eView: UIView!
    @IBOutlet weak var fView: UIView!
    @IBOutlet weak var fSView: UIView!
    @IBOutlet weak var GView: UIView!
    @IBOutlet weak var gSView: UIView!
    
    lazy var buttonViews: [UIView] = [aView,bBView,bView,cView,
                                      cSView,dView,eBView,eView,
                                      fView,fSView,GView,gSView]
    
    @IBOutlet weak var noteAButton: UIButton!
    @IBOutlet weak var noteBflatASharpButton: UIButton!
    @IBOutlet weak var noteBButton: UIButton!
    @IBOutlet weak var noteCButton: UIButton!
    @IBOutlet weak var noteCsharpDflatButton: UIButton!
    @IBOutlet weak var noteDButton: UIButton!
    @IBOutlet weak var noteEflatButton: UIButton!
    @IBOutlet weak var noteEButton: UIButton!
    @IBOutlet weak var noteFButton: UIButton!
    @IBOutlet weak var noteFsharpButton: UIButton!
    @IBOutlet weak var noteGButton: UIButton!
    @IBOutlet weak var noteGsharpButton: UIButton!
    
    lazy var noteButtons: [UIButton] = [noteAButton,noteBflatASharpButton,
    noteBButton,noteCButton,noteCsharpDflatButton,noteDButton,noteEflatButton,
    noteEButton,noteFsharpButton,noteFButton,noteGButton,noteGsharpButton]
    
    private func hideAllButtonsViews(){
        for button in noteButtons {
            button.isHidden = true
        }
        for view in buttonViews {
            view.isHidden = true
        }
    }
    
    func setPlayableNoteButtons(with notes: [Note]) {
        
        for note in notes {
            switch note.id {
            case 0: noteAButton.isHidden = false
                aView.isHidden = false
            case 1:noteBflatASharpButton.isHidden = false
                bBView.isHidden = false
            case 2:noteBButton.isHidden = false
                bView.isHidden = false
            case 3:noteCButton.isHidden = false
                cView.isHidden = false
            case 4:noteCsharpDflatButton.isHidden = false
                cSView.isHidden = false
            case 5:noteDButton.isHidden = false
                dView.isHidden = false
            case 6:noteEflatButton.isHidden = false
                eBView.isHidden = false
            case 7:noteEButton.isHidden = false
                eView.isHidden = false
            case 8:noteFButton.isHidden = false
                fView.isHidden = false
            case 9:noteFsharpButton.isHidden = false
                fSView.isHidden = false
            case 10:noteGButton.isHidden = false
                GView.isHidden = false
            case 11:noteGsharpButton.isHidden = false
                gSView.isHidden = false
            default: return
            }
        }
        
        
    }
    
    
    @IBAction func aButtonTapped(_ sender: Any) {
        gameController.checkUpdateSessionWith(note: Note(name: "A", id: 0))
    }
    @IBAction func bButtonTapped(_ sender: Any) {
        setPlayableNoteButtons(with: gameLesson.round2Notes)
    }
    @IBAction func cButtonTapped(_ sender: Any) {
    }
    @IBAction func dButtonTapped(_ sender: Any) {
    }
    @IBAction func eButtonTapped(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
