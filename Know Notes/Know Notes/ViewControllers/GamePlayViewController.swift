//
//  GamePlayViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/19/20.
//

import UIKit

class GamePlayViewController: UIViewController {

    //Example to display buttons
    var gameLesson: GameLesson = GameLesson(instrument: "Grand Piano", noteGroups: .allNotes)
    
    let gameController = GameLessonManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsedNoteButtons()
        gameController.setSessionNotes()
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
    
    
    @IBAction func aButtonTapped(_ sender: Any) {
        gameController.checkUpdateSessionWith(note: Note(name: "A", id: 0))
    }
    @IBAction func bButtonTapped(_ sender: Any) {
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
