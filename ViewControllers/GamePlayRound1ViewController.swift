//
//  GamePlayRound1ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import UIKit
import AVFoundation


class GamePlayRound1ViewController: UIViewController {
    
    static var lessonManager = Session.manager
    var instrumentType: InstrumentType = lessonManager.currentInstrumentType

    let hapticGenerator = UINotificationFeedbackGenerator()
    var musicSound: AVAudioPlayer?
    var customMode: Bool = false
    
    var gameRoundNotes: [Note] {
            return Session.manager.sessionNotes
    }
    var score: Int { Session.manager.score }

    var currentNote: Note?

    var note1: Note?
    var note2: Note?
    var note3: Note?
    
    lazy var noteSet: [Note?] = [note1,note2,note3]
    
    let totalGroupRounds: Double = 10.00
    var currentRound: Double = 1.00
    
    //AdvancedOptions
    var hasHalfNotes: Bool {
        return Session.manager.hasHalfNotes
    }
    
    var shuffleMode: ShuffleMode = .off
    
    var doesGameNeedNewNote: Bool = true
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
        setUpLabelsButtonsViews()
        assignNotesToButtons()
        self.isModalInPresentation = true
        setUpProgressBar()
        playButton.pulse()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateLifesGif()
        setUpLabelsButtonsViews()
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
    
    func setUpProgressBar(){
        circleProgressBar.labelSize = 60
        circleProgressBar.safePercent = 100
        circleProgressBar.lineWidth = 20
        circleProgressBar.safePercent = 100
        circleProgressBar.layer.backgroundColor = UIColor.gameplayBlue.cgColor
        circleProgressBar.layer.cornerRadius = circleProgressBar.frame.size.width/2
        circleProgressBar.clipsToBounds = true
        let gifImage = UIImage.gifImageWithName(name: "knowNotes5Lifes")
        backgroundGif.image = gifImage
        view.sendSubviewToBack(backgroundGif)
        view.sendSubviewToBack(circleProgressBar)
    }
    
    
    func getNewSessionNotes(){
        doesGameNeedNewNote = true
//        if customMode {
//            Session.manager.randomizeCustomRound1()
//            self.assignNotesToButtons()
//        }
           if hasHalfNotes{
            Session.manager.setRound1HalfNotes { (complete) in
                self.assignNotesToButtons()
            }
           } else if shuffleMode != .off {
            
            Session.manager.shuffleRound1Notes { (complete) in
                Session.manager.reuseRound1NoteSet()
                self.assignNotesToButtons()

            }
            
           } else {
            Session.manager.setRound1Notes { (complete) in
                self.assignNotesToButtons()
            }
           }
       }
    
    
    
    
    
    func assignNotesToButtons(){
        DispatchQueue.main.async {
            let note_1 = self.gameRoundNotes[0]
            let note_2 = self.gameRoundNotes[1]
            let note_3 = self.gameRoundNotes[2]
            self.note1 = note_1
            self.note2 = note_2
            self.note3 = note_3
            self.note1Button.tag = note_1.id
            self.note2Button.tag = note_2.id
            self.note3Button.tag = note_3.id
            self.note1Button.setTitle("\(note_1.name)", for: .normal)
            self.note2Button.setTitle("\(note_2.name)", for: .normal)
            self.note3Button.setTitle("\(note_3.name)", for: .normal)
            self.noteSet = [self.note1,self.note2,self.note3]
        }
    }
    
    func setUpLabelsButtonsViews(){
        playButton.layer.cornerRadius = 10
        shuffleSetButton.layer.cornerRadius = 10
        shuffleSetButton.layer.borderWidth = 2
        shuffleSetButton.layer.borderColor = UIColor.discoDayGReen.cgColor
        DispatchQueue.main.async {
            self.scoreLabel.text = "\(Session.manager.score)"
            self.playButton.setTitle("Play", for: .normal)
            self.playButton.pulse()
        }
    }
    
    //MARK: Update
    
    

    func updateLifesGif(){
        let lifesLeft = Session.manager.lifes
        if lifesLeft == 0 {
            return
        }
        let gifname = "knowNotes\(lifesLeft)Lifes"
        DispatchQueue.main.async {
            let gifImage = UIImage.gifImageWithName(name: gifname)
            self.backgroundGif.image = gifImage
        }
    }
    
    
    func updateProgressBar(){
        let progress = currentRound/totalGroupRounds
        circleProgressBar.setProgress(to: progress , withAnimation: false)
        self.currentRound = currentRound + 1.0
    }
    
    func resetGame() {
        currentRound = 1.0
        Session.manager.resetScores()
        Session.manager.reuseRound1NoteSet()
        setUpLabelsButtonsViews()
        stopPulsingNoteViews()
        circleProgressBar.setProgress(to: 0 , withAnimation: true)
    }
    
    func getNextNote(notes: [Note?])-> (nextNote:Note?, noteSet:[Note?] ) {
        var newNoteSet: [Note?] = []
        var newNote: Note? = nil
        var iterations = notes.count
        let noteIteration = 1
        repeat {
            if let nextNote = notes.randomElement() {
                if nextNote?.isRandomlySelected == false {
                    nextNote?.isRandomlySelected = true
                    newNote = nextNote
                    newNoteSet.append(newNote)
                }
                newNoteSet.append(newNote)
            }
            iterations += 1
        } while noteIteration <= iterations
           return (newNote,newNoteSet)
    }
    
    func checkRoundEnd(){
        if Session.manager.score >= 10 {
            self.performSegue(withIdentifier: "toRound2", sender: self)
        }
        if Session.manager.lifes == 0 {
            self.performSegue(withIdentifier: "round1Finish", sender: self)

        }
    }

    func byPassSilentMode(){
        do {
              try AVAudioSession.sharedInstance().setCategory(.playback)
           } catch(let error) {
               print(error.localizedDescription)
           }
    }
    
    func playSoundFromNote(path: String? ) {
        if let url = Session.manager.getSoundPathURLFromNote(path: path) {
        do {
            byPassSilentMode()
            musicSound = try AVAudioPlayer(contentsOf: url)
            musicSound?.play()
        } catch {
            // couldn't load file :(
        }
        }
    }
    
    
    func hasNotesBeenSelectedOnce()-> Bool {
        if score % 3 == 0 {
            return true
        } else { return false  }
    }
    
    func checkSetShouldShuffle(){
        if  hasNotesBeenSelectedOnce() {
            switch shuffleMode {
            case .auto:
                self.shuffleNotes(self)
            case .manual:
                self.showShuffleButtonModes()
            case .off:
                Session.manager.reuseRound1NoteSet()
            default:
                Session.manager.reuseRound1NoteSet()
            }
        }
    }
        
    func showShuffleButtonModes(){
        DispatchQueue.main.async {
            self.playButton.setTitle("Keep", for: .normal)
            self.shuffleSetButton.isHidden = false
            self.shuffleSetButton.isUserInteractionEnabled = true
            self.shuffleSetButton.pulse()
        }
    }
    
    func hideShuffleButton(){
        shuffleSetButton.isHidden = true
        shuffleSetButton.isUserInteractionEnabled = false
    }
    
    func handleWrongAnswerWithHaptic(){
        self.hapticGenerator.notificationOccurred(.error)
        UIView.animate(withDuration: 0.33) {
            self.view.backgroundColor = UIColor.imperialRed
            } completion: {
                (completed: Bool) -> Void in
                UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                    self.view.backgroundColor = UIColor.gameplayBlue
                }    }  }
    
    func handleCorrectAnswerWithHaptic(){
        checkSetShouldShuffle()
        self.hapticGenerator.notificationOccurred(.success)
        stopPulsingNoteButtons()
        UIView.animate(withDuration: 0.33) {
            self.view.backgroundColor = UIColor.pastelGReen
            } completion: {
                (completed: Bool) -> Void in
                UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                    self.view.backgroundColor = UIColor.gameplayBlue
                    self.playButton.pulse()
                }  }
    }

    //MARK: IBActions
    
    @IBAction func leaveButtonTapped(_ sender: Any) {
        self.present(quitGameActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if playButton.title(for: .normal) == "Keep" {
            Session.manager.reuseRound1NoteSet()
            DispatchQueue.main.async {
                self.playButton.setTitle("Play", for: .normal)
                self.hideShuffleButton()
            }
            doesGameNeedNewNote = true
            return
        }
        if doesGameNeedNewNote {
            let newNotes = Session.manager.getNewNote(notes: noteSet)
            let newNote = newNotes.nextNote
            let updatedSet = newNotes.noteSet
            noteSet = updatedSet
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
    
    @IBAction func shuffleNotes(_ sender: Any) {
        hideShuffleButton()
        DispatchQueue.main.async {
                self.getNewSessionNotes()
                self.playButton.setTitle("Play", for: .normal)
        }
        enableNoteButtons()
    }
    
    fileprivate func updateViewsWithCorrectAnswer(){
        
        DispatchQueue.main.async {
            self.playButton.setTitle("Play", for: .normal)
            self.scoreLabel.text = "\(Session.manager.score)"
            self.updateProgressBar()
            self.handleCorrectAnswerWithHaptic()
        }
        doesGameNeedNewNote = true
    }
    
    fileprivate func updateButtonAndViewWithIncorrectAnswer(noteButton: UIButton) {
        //wrong
        if noteButton == note1Button{
            self.note1Button.layer.removeAllAnimations()
            self.note1ButtonView.layer.removeAllAnimations()
            self.note1Button.isEnabled = false
        } else if noteButton == note2Button {
            self.note2Button.layer.removeAllAnimations()
            self.note2ButtonView.layer.removeAllAnimations()
            self.note2Button.isEnabled = false
        } else if noteButton == note3Button {
            self.note3Button.layer.removeAllAnimations()
            self.note3ButtonView.layer.removeAllAnimations()
            self.note3Button.isEnabled = false
        }
        handleWrongAnswerWithHaptic()
        DispatchQueue.main.async {
            self.updateLifesGif()
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
            if Session.manager.checkUpdateSessionWith(note: note1) {
                updateViewsWithCorrectAnswer()
            } else {
                updateButtonAndViewWithIncorrectAnswer(noteButton: note1Button)
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
            if Session.manager.checkUpdateSessionWith(note: note2) {
                //correct
               updateViewsWithCorrectAnswer()
            } else {
                updateButtonAndViewWithIncorrectAnswer(noteButton: note2Button)
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
            if Session.manager.checkUpdateSessionWith(note: note3) {
                updateViewsWithCorrectAnswer()
            } else {
                updateButtonAndViewWithIncorrectAnswer(noteButton: note3Button)
            }
        }
        checkRoundEnd()
    }
    
    //MARK: ALERTS & Modules
    
    var finishedGameAlert: UIAlertController {
        let alert = UIAlertController(title: "Finished", message: "Would you like to submit score to GameCenter?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Submit Score", style: .default) { (_) in
            
            let score: Int = Session.manager.score
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
        let action2 = UIAlertAction(title: "Discard Round", style: .destructive) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        let action3 = UIAlertAction(title: "Replay Round", style: .default) { (_) in
            self.resetGame()
        }
        
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action)
        return alert
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
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shuffleSetButton: UIButton!
    
    
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
        if let vc = segue.destination as? CustomAlertViewController {
            vc.isUsingHalfs = self.hasHalfNotes

            
        }
        
        if segue.identifier == "toRound2" {
            if let vc = segue.destination as? GamePlayRound2ViewController {
                vc.getGameNotes()
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
