//
//  GamePlayRound1ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import UIKit
import AVFoundation


class GamePlayRound1ViewController: UIViewController {
    
    var instrumentType: InstrumentType = .grandPiano
    
    var gameRoundNotes: [Note] = LessonSession.manager.lesson.round1Notes
    
    var note1: Note?
    var note2: Note?
    var note3: Note?
    
    var currentNote: Note?
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    var musicSound: AVAudioPlayer?
    
    func byPassSilentMode(){
        do {
              try AVAudioSession.sharedInstance().setCategory(.playback)
           } catch(let error) {
               print(error.localizedDescription)
           }
    }
    
    var doesGameNeedNewNote: Bool = true
    
    var finishedGameAlert: UIAlertController {
        let alert = UIAlertController(title: "Game Finished", message: "Would you like to submit score to Lederboard?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            let score: Int = LessonSession.manager.score
            
            if self.instrumentType == .grandPiano {
                GameCenterManager.manager.leaderboardsManager.finishedRound1GrandPianoNotes()
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularGrandPiano)
                self.dismiss(animated: true, completion: nil)
                
            } else if self.instrumentType == .acousticGuitar {
                GameCenterManager.manager.leaderboardsManager.finishedRound1AcousticGuitarNotes()
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularAcousticGuitar)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        alert.addAction(action2)
        return alert
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        assignNotesToButtons()
        setUpLabelsButtonsViews()
        //scoreUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //test to skip to round 3
    func scoreUpdate(){
        LessonSession.manager.score = 10
    }
    
    //MARK: SetUp
    
    func assignNotesToButtons(){
        let note_1 = gameRoundNotes[0]
        let note_2 = gameRoundNotes[1]
        let note_3 = gameRoundNotes[2]
        note1 = note_1
        note2 = note_2
        note3 = note_3
        note1Button.tag = note_1.id
        note2Button.tag = note_2.id
        note3Button.tag = note_3.id
        note1Button.setTitle("\(note_1.name)", for: .normal)
        note2Button.setTitle("\(note_2.name)", for: .normal)
        note3Button.setTitle("\(note_3.name)", for: .normal)

    }
    
    func setUpLabelsButtonsViews(){
        lifesLabel.text = "\(LessonSession.manager.lifes)"
        scoreLabel.text = "\(LessonSession.manager.score)"
        playButton.layer.cornerRadius = 10
    }
    
    

    func checkRoundEnd(){
        if LessonSession.manager.score >= 10 {
            self.performSegue(withIdentifier: "toRound2", sender: self)
        }
        if LessonSession.manager.lifes == 0 {
            self.present(finishedGameAlert, animated: true) {
                //Possible unwind segue area
            }
        }
    }
    
    func playSoundFromNote(path: String? ) {
        if let url = LessonSession.manager.getSoundPathURLFromNote(path: path) {
        do {
            byPassSilentMode()
            musicSound = try AVAudioPlayer(contentsOf: url)
            musicSound?.play()
        } catch {
            // couldn't load file :(
        }
            
        }
    }
    
    func handleWrongAnswerWithHaptic(){
        self.hapticGenerator.notificationOccurred(.error)
        
        UIView.animate(withDuration: 0.33) {
                self.view.backgroundColor = UIColor.systemRed
            } completion: {
                (completed: Bool) -> Void in
                UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                    self.view.backgroundColor = UIColor.deepSea
                }
            }
        }
    func handleCorrectAnswerWithHaptic(){
        self.hapticGenerator.notificationOccurred(.success)
        
        UIView.animate(withDuration: 0.33) {
                self.view.backgroundColor = UIColor.systemGreen
            } completion: {
                (completed: Bool) -> Void in
                UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                    self.view.backgroundColor = UIColor.deepSea
                }
            }
        }

    //MARK: Actions
    @IBAction func playButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            let newNote = LessonSession.manager.getNextNote()
             currentNote = newNote
             playSoundFromNote(path: newNote?.soundPath )
            doesGameNeedNewNote = false
            DispatchQueue.main.async {
                self.playButton.setTitle("Repeat", for: .normal)
            }
        } else {
            playSoundFromNote(path: currentNote?.soundPath)
        }
    }
    
    @IBAction func note1ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        
        if let note1 = note1 {
            playSoundFromNote(path: note1.soundPath)
            if LessonSession.manager.checkUpdateSessionWith(note: note1) {
                //correct
                handleCorrectAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.playButton.setTitle("Play", for: .normal)
                    self.scoreLabel.text = "\(LessonSession.manager.score)"
                }
                doesGameNeedNewNote = true
            } else {
                //wrong
                handleWrongAnswerWithHaptic()
                lifesLabel.text = "\(LessonSession.manager.lifes)"
            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note2ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if let note2 = note2 {
            playSoundFromNote(path: note2.soundPath)
            if LessonSession.manager.checkUpdateSessionWith(note: note2) {
                //correct
                handleCorrectAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.playButton.setTitle("Play", for: .normal)
                    self.scoreLabel.text = "\(LessonSession.manager.score)"
                }
                doesGameNeedNewNote = true
            } else {
                //wrong
                handleWrongAnswerWithHaptic()
                lifesLabel.text = "\(LessonSession.manager.lifes)"
            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note3ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if let note3 = note3 {
            playSoundFromNote(path: note3.soundPath)
            if LessonSession.manager.checkUpdateSessionWith(note: note3) {
                //correct
                handleCorrectAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.playButton.setTitle("Play", for: .normal)
                    self.scoreLabel.text = "\(LessonSession.manager.score)"
                }
                doesGameNeedNewNote = true
            } else {
                //wrong
                handleWrongAnswerWithHaptic()
                lifesLabel.text = "\(LessonSession.manager.lifes)"
            }
        }
        checkRoundEnd()
    }
    
    
    //MARK: Outlets

    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    @IBOutlet weak var note1ButtonView: UIView!
    @IBOutlet weak var note2ButtonView: UIView!
    @IBOutlet weak var note3ButtonView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifesLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "toRound2" {
            if let vc = segue.destination as? GamePlayRound2ViewController {
                LessonSession.manager.setRound2Notes()
                vc.instrumentType = self.instrumentType
                if instrumentType == .grandPiano {
                    GameCenterManager.manager.leaderboardsManager.finishedRound1GrandPianoNotes()
                } else if instrumentType == .acousticGuitar {
                    GameCenterManager.manager.leaderboardsManager.finishedRound1AcousticGuitarNotes()
                }
            }
            
        }
    }
    

}
