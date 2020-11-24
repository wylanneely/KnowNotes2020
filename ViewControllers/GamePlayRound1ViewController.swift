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
        let alert = UIAlertController(title: "Finished", message: "Would you like to submit score to GameCenter?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Submit Score", style: .default) { (_) in
            let score: Int = LessonSession.manager.score
            
            if self.instrumentType == .grandPiano {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularGrandPiano)
                GameCenterManager.manager.leaderboardsManager.setPersonalGranPianoHighScore(score: score)
                self.dismiss(animated: true, completion: nil)
                
            } else if self.instrumentType == .acousticGuitar {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularAcousticGuitar)
                GameCenterManager.manager.leaderboardsManager.setPersonalAcouGuitarHighScore(score: score)
                self.dismiss(animated: true, completion: nil)
            }
            else if self.instrumentType == .violin {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularViolin)
                GameCenterManager.manager.leaderboardsManager.setPersonalViolinHighScore(score: score)
                self.dismiss(animated: true, completion: nil)
            }
            else if self.instrumentType == .saxaphone {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularSaxaphone)
                GameCenterManager.manager.leaderboardsManager.setPersonalSaxaphoneHighScore(score: score)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        let action3 = UIAlertAction(title: "Discard Round", style: .cancel) { [self] (_) in
            let score: Int = LessonSession.manager.score
            
            if self.instrumentType == .grandPiano {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularGrandPiano)
                GameCenterManager.manager.leaderboardsManager.setPersonalGranPianoHighScore(score: score)
                resetGame()
            } else if self.instrumentType == .acousticGuitar {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularAcousticGuitar)
                GameCenterManager.manager.leaderboardsManager.setPersonalAcouGuitarHighScore(score: score)
                resetGame()
            }
            else if self.instrumentType == .violin {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularViolin)
                GameCenterManager.manager.leaderboardsManager.setPersonalViolinHighScore(score: score)
                resetGame()
            }
            else if self.instrumentType == .saxaphone {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularSaxaphone)
                GameCenterManager.manager.leaderboardsManager.setPersonalSaxaphoneHighScore(score: score)
                resetGame()
            }
        }
        
        let action2 = UIAlertAction(title: "Discard Round", style: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action2)

        alert.addAction(action)
        return alert
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignNotesToButtons()
        setUpLabelsButtonsViews()
        self.isModalInPresentation = true
        setUpGif()
        playButton.pulse()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        playButton.pulse()
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
        playButton.layer.cornerRadius = 10
        DispatchQueue.main.async {
            self.lifesLabel.text = "\(LessonSession.manager.lifes)"
            self.scoreLabel.text = "\(LessonSession.manager.score)"
            self.playButton.setTitle("Play", for: .normal)
            self.playButton.pulse()
        }
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
            self.view.backgroundColor = UIColor.imperialRed
            } completion: {
                (completed: Bool) -> Void in
                UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                    self.view.backgroundColor = UIColor.gameplayBlue
                }
            }
        }
    
    func handleCorrectAnswerWithHaptic(){
        self.hapticGenerator.notificationOccurred(.success)
        stopPulsingNoteButtons()
        UIView.animate(withDuration: 0.33) {
            self.view.backgroundColor = UIColor.pastelGReen
            } completion: {
                (completed: Bool) -> Void in
                UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                    self.view.backgroundColor = UIColor.gameplayBlue
                    self.playButton.pulse()
                }
            }
        }
    
    var quitGameActionSheet: UIAlertController {
        let quitGameActionSheet = UIAlertController(title: "Quit Game?", message: "Are you sure you would like to leave? Any progress made will not be saved.", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            self.isModalInPresentation = false
            self.dismiss(animated: true, completion: nil)
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
        //circleProgressBar.setProgress(to: 100, withAnimation: true)
        if doesGameNeedNewNote {
            let newNote = LessonSession.manager.getNextNote()
            currentNote = newNote
            playSoundFromNote(path: newNote?.soundPath )
            doesGameNeedNewNote = false
            enableNoteButtons()
            DispatchQueue.main.async {
                self.playButton.setTitle("Repeat", for: .normal)
                self.pulseAllNoteButtons()
            }
        } else {
            playSoundFromNote(path: currentNote?.soundPath)
        }
    }
    
    @IBAction func note1ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if note1Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
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
                self.note1Button.layer.removeAllAnimations()
                self.note1ButtonView.layer.removeAllAnimations()
                handleWrongAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.lifesLabel.text = "\(LessonSession.manager.lifes)"
                }
                note1Button.isEnabled = false
            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note2ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if note2Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
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
                note2Button.layer.removeAllAnimations()
                self.note2ButtonView.layer.removeAllAnimations()
                handleWrongAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.lifesLabel.text = "\(LessonSession.manager.lifes)"
                }
                note2Button.isEnabled = false
            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note3ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        if note3Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
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
                self.note3Button.layer.removeAllAnimations()
                self.note3ButtonView.layer.removeAllAnimations()
                handleWrongAnswerWithHaptic()
                DispatchQueue.main.async {
                    self.lifesLabel.text = "\(LessonSession.manager.lifes)"
                }
                note3Button.isEnabled = false
            }
        }
        checkRoundEnd()
    }
    
    //MARK: Helper Functions

    func setUpGif(){
          circleProgressBar.labelSize = 60
          circleProgressBar.safePercent = 100
          circleProgressBar.lineWidth = 20
          circleProgressBar.safePercent = 100
          circleProgressBar.layer.backgroundColor = UIColor.gameplayBlue.cgColor
        circleProgressBar.layer.cornerRadius = circleProgressBar.frame.size.width/2
        circleProgressBar.clipsToBounds = true
          view.sendSubviewToBack(backgroundGif)
          let gifImage = UIImage.gifImageWithName(name: "musicBackground")
          backgroundGif.image = gifImage?.circleMasked
          view.sendSubviewToBack(circleProgressBar)
      }

    let totalGroupRounds: Double = 10.00
    var currentRound: Double = 1.00
    
    func updateProgressBar(){
        let progress = currentRound/totalGroupRounds
        circleProgressBar.setProgress(to: progress , withAnimation: false)
        self.currentRound = currentRound + 1.0
    }
    
    func resetGame() {
        currentRound = 1.0
        LessonSession.manager.resetScores()
        setUpLabelsButtonsViews()
        stopPulsingNoteViews()
            circleProgressBar.setProgress(to: 0 , withAnimation: true)
    }
    
    //MARK: Outlets
    
    @IBOutlet weak var backgroundGif: UIImageView!
    @IBOutlet weak var circleProgressBar: CircularProgressBar!
    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    @IBOutlet weak var note1ButtonView: UIView!
    @IBOutlet weak var note2ButtonView: UIView!
    @IBOutlet weak var note3ButtonView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifesLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    //MARK: IB Helpers
    lazy var allNoteButtons: [UIButton] = [note1Button,note2Button,note3Button]
    lazy var allNoteViews: [UIView] = [note1ButtonView,note2ButtonView,note3ButtonView]
    
    func pulseAllNoteButtons(){
        for button in allNoteButtons {
            button.pulsate()
        }
        pulseAllNoteViews()
    }
    func stopPulsingNoteButtons(){
        for button in allNoteButtons {
            button.layer.removeAllAnimations()
        }
        stopPulsingNoteViews()
    }
    func enableNoteButtons(){
        for button in allNoteButtons {
            button.isEnabled = true
        }
        pulseAllNoteViews()
    }
    func pulseAllNoteViews(){
            for view in allNoteViews {
                view.pulsateView()
            }
        }
    func stopPulsingNoteViews(){
        for view in allNoteViews {
            view.layer.removeAllAnimations()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRound2" {
            if let vc = segue.destination as? GamePlayRound2ViewController {
                LessonSession.manager.setRound2Notes()
                vc.instrumentType = self.instrumentType
                if instrumentType == .grandPiano {
                    GameCenterManager.manager.leaderboardsManager.finishedRound1GrandPianoNotes()
                } else if instrumentType == .acousticGuitar {
                    GameCenterManager.manager.leaderboardsManager.finishedRound1AcousticGuitarNotes()
                }  else if instrumentType == .violin {
                    GameCenterManager.manager.leaderboardsManager.finishedRound1ViolinNotes()
                }   else if instrumentType == .saxaphone {
                    GameCenterManager.manager.leaderboardsManager.finishedRound1SaxNotes()
                }
            }
        }
    }
    

}
