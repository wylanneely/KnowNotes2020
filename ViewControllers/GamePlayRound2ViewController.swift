//
//  GamePlayRound2ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import UIKit
import AVFoundation

class GamePlayRound2ViewController: UIViewController {
    
    var instrumentType: InstrumentType = .grandPiano
    
    var gameRoundNotes: [Note] = LessonSession.manager.lesson.round2Notes
    
    var isStartingRound: Bool = false
    
    var note1: Note?
    var note2: Note?
    var note3: Note?
    var note4: Note?
    var note5: Note?
    
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
                GameCenterManager.manager.leaderboardsManager.finishedRound2GrandPianoNotes()
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularGrandPiano)
                GameCenterManager.manager.achievementsManager.reportUnlockAcousticGuitarProgress(with: score)
                GameCenterManager.manager.leaderboardsManager.setPersonalGranPianoHighScore(score: score)
                self.performSegue(withIdentifier: "toLocalProfile", sender: self)
            } else if self.instrumentType == .acousticGuitar {
                GameCenterManager.manager.leaderboardsManager.finishedRound2AcousticGuitarNotes()
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularAcousticGuitar)
                GameCenterManager.manager.leaderboardsManager.setPersonalAcouGuitarHighScore(score: score)
                self.performSegue(withIdentifier: "toLocalProfile", sender: self)
            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            self.performSegue(withIdentifier: "toLocalProfile", sender: self)
        }
        
        alert.addAction(action)
        alert.addAction(action2)
        return alert
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignNotesToButtons()
        setUpScoresLifes()
        self.isModalInPresentation = true
        setUpGif()
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
        lifesLabel.text = "\(LessonSession.manager.lifes)"
        scoreLabel.text = "\(LessonSession.manager.score)"
        playButton.layer.cornerRadius = 10
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
                self.view.backgroundColor = UIColor.gameplayBlue
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
                self.view.backgroundColor = UIColor.gameplayBlue
            }
        }
    }
    
    var quitGameActionSheet: UIAlertController {
        let quitGameActionSheet = UIAlertController(title: "Quit Game?", message: "Are you sure you would like to go back? Any progress made will not be saved.", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            self.isModalInPresentation = false
            self.performSegue(withIdentifier: "toLocalProfile", sender: self)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            return
        }
        quitGameActionSheet.addAction(noAction)
        quitGameActionSheet.addAction(yesAction)
        return quitGameActionSheet
    }
    
    //MARK: Actions
    @IBAction func leaveButtonTapped(_ sender: Any) {
        self.present(quitGameActionSheet, animated: true, completion: nil)
    }
    
    
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
                    self.updateProgressBar()

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
                    self.updateProgressBar()
                    
                }
                doesGameNeedNewNote = true
            } else {
                //wrong
                handleWrongAnswerWithHaptic()
                lifesLabel.text = "\(LessonSession.manager.lifes)" }
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
                    self.updateProgressBar()

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
    
    @IBAction func note4ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if let note4 = note4 {
            playSoundFromNote(path: note4.soundPath)
            if LessonSession.manager.checkUpdateSessionWith(note: note4) {
                //correct
                handleCorrectAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.playButton.setTitle("Play", for: .normal)
                    self.scoreLabel.text = "\(LessonSession.manager.score)"
                    self.updateProgressBar()
                }
                doesGameNeedNewNote = true
            } else {
                //wrong
                handleWrongAnswerWithHaptic()
                lifesLabel.text = "\(LessonSession.manager.lifes)" }
        }
        checkRoundEnd()
    }
    
    @IBAction func note5ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if let note5 = note5 {
            playSoundFromNote(path: note5.soundPath)
            
            if LessonSession.manager.checkUpdateSessionWith(note: note5) {
                //correct
                handleCorrectAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.playButton.setTitle("Play", for: .normal)
                    self.scoreLabel.text = "\(LessonSession.manager.score)"
                    self.updateProgressBar()
                }
                doesGameNeedNewNote = true
            } else {
                //wrong
                lifesLabel.text = "\(LessonSession.manager.lifes)"
                handleWrongAnswerWithHaptic()
            }
        }
        checkRoundEnd()
    }
    
    //MARK: Helper Functions

    func setUpGif(){
          circleProgressBar.labelSize = 60
          circleProgressBar.safePercent = 100
          circleProgressBar.lineWidth = 12
          circleProgressBar.safePercent = 100
          circleProgressBar.layer.backgroundColor = UIColor.gameplayBlue.cgColor
        circleProgressBar.layer.cornerRadius = circleProgressBar.frame.size.width/2
        circleProgressBar.clipsToBounds = true
          view.sendSubviewToBack(backgroundGif)
          let gifImage = UIImage.gifImageWithName(name: "musicBackground")
         // self.view.largeContentImage = gifImage
          backgroundGif.image = gifImage?.circleMasked
          view.sendSubviewToBack(circleProgressBar)
      }
    
    let totalGroupRounds: Double = 15.00
    var currentRound: Double = 1.00
    
    func updateProgressBar(){
        let progress = currentRound/totalGroupRounds
        circleProgressBar.setProgress(to: progress , withAnimation: false)
        self.currentRound = currentRound + 1.0
    }
    
    func checkRoundEnd(){
        
        
        if isStartingRound {
            if currentRound >= 15 {
                self.performSegue(withIdentifier: "toRound3", sender: self)
            }
            if LessonSession.manager.lifes == 0 {
                self.present(finishedGameAlert, animated: true) {
                }
            }
            
            
        } else {
          
            if LessonSession.manager.score >= 25 {
                self.performSegue(withIdentifier: "toRound3", sender: self)
            }
            if LessonSession.manager.lifes == 0 {
                self.present(finishedGameAlert, animated: true) {
                    //Possible unwind segue area
                }
            }
        }
        
        
        
    }
    
    
    //MARK: Outlets
    
    @IBOutlet weak var backgroundGif: UIImageView!
    @IBOutlet weak var circleProgressBar: CircularProgressBar!
    
    @IBOutlet weak var playButton: UIButton!
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "toRound3" {
            if let vc = segue.destination as? GamePlayRound2ViewController {
                vc.instrumentType = self.instrumentType
                LessonSession.manager.setRound3Notes()
                if instrumentType == .grandPiano {
                    GameCenterManager.manager.leaderboardsManager.finishedRound2GrandPianoNotes()
                } else if instrumentType == .acousticGuitar {
                    GameCenterManager.manager.leaderboardsManager.finishedRound2AcousticGuitarNotes()
                }
            }
        }
        if segue.identifier == "toLocalProfile" {
            if let vc = segue.destination as? LocalPlayerMenuViewController {
                
            }
        }
    }
    

}
