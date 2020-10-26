//
//  GamePlayRound2ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import UIKit
import AVFoundation

class GamePlayRound2ViewController: UIViewController {
    
    var gameRoundNotes: [Note] = GameLessonManager.manager.lesson.round2Notes
    
    var note1: Note?
    var note2: Note?
    var note3: Note?
    var note4: Note?
    var note5: Note?
    
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    var musicSound: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        assignNotesToButtons()
        // Do any additional setup after loading the view.
    }
    
    //MARK: SetUp
    
    func assignNotesToButtons(){
        let note_1 = gameRoundNotes[0]
        let note_2 = gameRoundNotes[1]
        let note_3 = gameRoundNotes[2]
        let note_4 = gameRoundNotes[3]
        let note_5 = gameRoundNotes[4]
        note1 = note_1
        note2 = note_2
        note3 = note_3
        note4 = note_4
        note5 = note_5
        note1Button.tag = note_1.id
        note2Button.tag = note_2.id
        note3Button.tag = note_3.id
        note4Button.tag = note_4.id
        note5Button.tag = note_5.id
        note1Button.setTitle("\(note_1.name)", for: .normal)
        note2Button.setTitle("\(note_2.name)", for: .normal)
        note3Button.setTitle("\(note_3.name)", for: .normal)
        note4Button.setTitle("\(note_4.name)", for: .normal)
        note5Button.setTitle("\(note_5.name)", for: .normal)
    }
    
    func setUpScoresLifes(){
        lifesLabel.text = "\(GameLessonManager.manager.lifes)"
        scoreLabel.text = "\(GameLessonManager.manager.score)"
    }
    
    var currentNote: Note?

    func checkRoundEnd(){
        if GameLessonManager.manager.score >= 25 {
            
        }
        if GameLessonManager.manager.lifes == 0 {
            
        }
    }
    
    func playSoundFromNote(path: String? ) {
        if let url = GameLessonManager.manager.getSoundPathURLFromNote(path: path) {
        do {
            musicSound = try AVAudioPlayer(contentsOf: url)
            musicSound?.play()
        } catch {
            // couldn't load file :(
        }
            
        }
    }
    
    //MARK: Actions
    
    @IBAction func playButtonTapped(_ sender: Any) {
        let newNote = GameLessonManager.manager.getNextNote()
         currentNote = newNote
         //PlaySound
        playSoundFromNote(path: newNote?.soundPath)
    }
    

    
    
    
    @IBAction func note1ButtonTapped(_ sender: Any) {
        if let note1 = note1 {
            playSoundFromNote(path: note1.soundPath)

            
            if GameLessonManager.manager.checkUpdateSessionWith(note: note1) {
                //correct
                scoreLabel.text = "\(GameLessonManager.manager.score)"
            } else {
                //wrong
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"

            }
        }
        checkRoundEnd()
    }
    
    
    
    @IBAction func note2ButtonTapped(_ sender: Any) {
        if let note2 = note2 {
            playSoundFromNote(path: note2.soundPath)

            if GameLessonManager.manager.checkUpdateSessionWith(note: note2) {
                //correct
                scoreLabel.text = "\(GameLessonManager.manager.score)"
            } else {
                //wrong
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"
            }
        }
        checkRoundEnd()

    }
    @IBAction func note3ButtonTapped(_ sender: Any) {
        if let note3 = note3 {
            playSoundFromNote(path: note3.soundPath)

            if GameLessonManager.manager.checkUpdateSessionWith(note: note3) {
                //correct
                scoreLabel.text = "\(GameLessonManager.manager.score)"

            } else {
                //wrong
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"

            }
        }
    }
    @IBAction func note4ButtonTapped(_ sender: Any) {
        if let note4 = note4 {
            playSoundFromNote(path: note4.soundPath)

            if GameLessonManager.manager.checkUpdateSessionWith(note: note4) {
                //correct
                scoreLabel.text = "\(GameLessonManager.manager.score)"

            } else {
                //wrong
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"

            }
        }
    }
    @IBAction func note5ButtonTapped(_ sender: Any) {
        if let note5 = note5 {
            playSoundFromNote(path: note5.soundPath)

            if GameLessonManager.manager.checkUpdateSessionWith(note: note5) {
                //correct
                scoreLabel.text = "\(GameLessonManager.manager.score)"

            } else {
                //wrong
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"

            }
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifesLabel: UILabel!
    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    @IBOutlet weak var note4Button: UIButton!
    @IBOutlet weak var note5Button: UIButton!
    
    
    
    @IBOutlet weak var note5ButtonView: UIView!
    @IBOutlet weak var note1ButtonView: UIView!
    @IBOutlet weak var note2ButtonView: UIView!
    @IBOutlet weak var note3ButtonView: UIView!
    @IBOutlet weak var note4ButtonView: UIView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
