//
//  GamePlayRound3ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import UIKit
import AVFoundation

class GamePlayRound3ViewController: UIViewController {

    var instrumentType: InstrumentType = .acousticGuitar
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    var musicSound: AVAudioPlayer?
    var gameRoundNotes: [Note] {
        return Session.manager.sessionNotes
    }
    var isStartingRound: Bool = false

    
    //AdvancedOptions
    var hasHalfNotes: Bool
    {
        return Session.manager.hasHalfNotes
    }
    var shuffleMode: ShuffleMode = .off
    var score: Int { Session.manager.score }

    
    //Notes helpers
    var doesGameNeedNewNote: Bool = true
    var currentNote: Note?

    var note1: Note?
    var note2: Note?
    var note3: Note?
    var note4: Note?
    var note5: Note?
    var note6: Note?
    var note7: Note?
    
    lazy var noteSet: [Note?] = [note1,note2,note3,note4,note5,note6,note7]


        //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
        assignNotesToButtons()
        setUpScoresLifes()
        self.isModalInPresentation = true
        setUpGif()
        playButton.pulse()
        updateLifesGif(Session.manager.lifes)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        resetGame()
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
    
    //MARK: SetUp
    
    func getGameNotes(){
        doesGameNeedNewNote = true
        if hasHalfNotes {
            Session.manager.setRound3HalfNotes { (_) in
            }
        } else {
            Session.manager.setRound3Notes { (_) in
            }
        }
    }
    
    func assignNotesToButtons(){
        DispatchQueue.main.async { [self] in
        let note_1 = gameRoundNotes[0]
        let note_2 = gameRoundNotes[1]
        let note_3 = gameRoundNotes[2]
        let note_4 = gameRoundNotes[3]
        let note_5 = gameRoundNotes[4]
        let note_6 = gameRoundNotes[5]
        let note_7 = gameRoundNotes[6]
        note1 = note_1
        note2 = note_2
        note3 = note_3
        note4 = note_4
        note5 = note_5
        note6 = note_6
        note7 = note_7
        note1Button.tag = note_1.id
        note2Button.tag = note_2.id
        note3Button.tag = note_3.id
        note4Button.tag = note_4.id
        note5Button.tag = note_5.id
        note6Button.tag = note_6.id
        note7Button.tag = note_7.id
            note1Button.setTitle("\(note_1.name)", for: .normal)
            note2Button.setTitle("\(note_2.name)", for: .normal)
            note3Button.setTitle("\(note_3.name)", for: .normal)
            note4Button.setTitle("\(note_4.name)", for: .normal)
            note5Button.setTitle("\(note_5.name)", for: .normal)
            note6Button.setTitle("\(note_6.name)", for: .normal)
            note7Button.setTitle("\(note_7.name)", for: .normal)
            noteSet = [note1,note2,note3,note4,note5,note6,note7]
        }
    }
    
    func setUpScoresLifes(){
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
    
    func checkRoundEnd(){
        if Session.manager.lifes == 0 {
            self.performSegue(withIdentifier: "round3Finish", sender: self)
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
        checkSetShouldShuffle()
        self.hapticGenerator.notificationOccurred(.success)
        stopPulsingNoteButtons()
        UIView.animate(withDuration: 0.33) {
            self.view.backgroundColor = UIColor.systemGreen
        } completion: {
            (completed: Bool) -> Void in
            UIView.animateKeyframes(withDuration: 0.33, delay: 0, options: .calculationModePaced) {
                self.view.backgroundColor = UIColor.gameplayBlue
                self.playButton.pulse()
            }
        }
    }
    
    func hasNotesBeenSelectedOnce()-> Bool {
        if score % 5 == 0 {
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
    
    func byPassSilentMode(){
        do {
              try AVAudioSession.sharedInstance().setCategory(.playback)
           } catch(let error) {
               print(error.localizedDescription)
           }
    }
    func shuffleNotes(){
        if hasHalfNotes{
            Session.manager.setRound3HalfNotes { (_) in
                Session.manager.reuseRound3NoteSet()
                assignNotesToButtons()
            }
        } else {
            Session.manager.setRound3Notes { (_) in
                Session.manager.reuseRound3NoteSet()
                assignNotesToButtons()
            }
        }
    }
   
    
    func showShuffleButtonModes(){
        DispatchQueue.main.async {
            self.shuffleSetButton.isHidden = false
            self.shuffleSetButton.isUserInteractionEnabled = true
            self.shuffleSetButton.pulse()
            self.playButton.setTitle("Keep", for: .normal)
        }
    }
    
    func hideShuffleButton(){
        shuffleSetButton.isHidden = true
        shuffleSetButton.isUserInteractionEnabled = false
    }
    
    func updateLifesGif(_ lifesLeft: Int){
        if lifesLeft == 0 {
            return
        }
        let gifname = "knowNotes\(lifesLeft)Lifes"
        let gifImage = UIImage.gifImageWithName(name: gifname)
        backgroundGif.image = gifImage
    }
    
    fileprivate func updateViewsWithCorrectAnswer(){
        DispatchQueue.main.async {
            self.playButton.setTitle("Play", for: .normal)
            self.scoreLabel.text = "\(Session.manager.score)"
            self.handleCorrectAnswerWithHaptic()
        }
        doesGameNeedNewNote = true
    }
    
    fileprivate func updateViewsWithIncorrectAnswer() {
        //wrong
        self.note1Button.layer.removeAllAnimations()
        self.note1ButtonView.layer.removeAllAnimations()
        handleWrongAnswerWithHaptic()
        DispatchQueue.main.async {
            self.updateLifesGif(Session.manager.lifes)
        }
        note1Button.isEnabled = false
    }
    
    //MARK: Actions
    
    @IBAction func leaveButtonTapped(_ sender: Any) {
        self.present(quitGameActionSheet, animated: true, completion: nil)
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if playButton.title(for: .normal) == "Keep" {
            Session.manager.reuseRound3NoteSet()
            doesGameNeedNewNote = true
            DispatchQueue.main.async {
                self.playButton.setTitle("Play", for: .normal)
                self.hideShuffleButton()
            }
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
        shuffleNotes()
        DispatchQueue.main.async {
                self.shuffleNotes()
                self.playButton.setTitle("Play", for: .normal)
                self.pulseAllNoteButtons()
                self.assignNotesToButtons()
        }
        enableNoteButtons()
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
                updateViewsWithCorrectAnswer()
            } else {
                updateViewsWithIncorrectAnswer()
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
                updateViewsWithIncorrectAnswer()
            }
        }
        checkRoundEnd()
    }
    @IBAction func note4ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        
        if note4Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
            return
        }
        if let note4 = note4 {
            playSoundFromNote(path: note4.soundPath)
            if Session.manager.checkUpdateSessionWith(note: note4) {
                updateViewsWithCorrectAnswer()
            } else {
                updateViewsWithIncorrectAnswer()
            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note5ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        
        if note5Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
            return
        }
        if let note5 = note5 {
            playSoundFromNote(path: note5.soundPath)

            if Session.manager.checkUpdateSessionWith(note: note5) {
                updateViewsWithCorrectAnswer()
            } else {
                updateViewsWithIncorrectAnswer()
            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note6ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        
        if note6Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
            return
        }
        if let note6 = note6 {
            playSoundFromNote(path: note6.soundPath)

            if Session.manager.checkUpdateSessionWith(note: note6) {
                updateViewsWithCorrectAnswer()
            } else {
                updateViewsWithIncorrectAnswer()

            }
        }
        checkRoundEnd()
    }
    
    @IBAction func note7ButtonTapped(_ sender: Any) {
        if doesGameNeedNewNote {
            return
        }
        
        if note7Button.isEnabled == false {
            handleWrongAnswerWithHaptic()
            return
        }
        if let note7 = note7 {
            playSoundFromNote(path: note7.soundPath)

            if Session.manager.checkUpdateSessionWith(note: note7) {
                updateViewsWithCorrectAnswer()
            } else {
                updateViewsWithIncorrectAnswer()
            }
        }
        checkRoundEnd()
    }
    
    //MARK: Helper Functions

    func setUpGif(){
        updateLifesGif(Session.manager.lifes)
      }
 
    //MARK: Alerts
    
    var quitGameActionSheet: UIAlertController {
        let quitGameActionSheet = UIAlertController(title: "Quit Game?", message: "Are you sure you would like to leave? Any progress made will not be saved.", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            self.isModalInPresentation = false
            self.performSegue(withIdentifier: "toLocalProfile2", sender: self)
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            return
        }
        quitGameActionSheet.addAction(noAction)
        quitGameActionSheet.addAction(yesAction)
        return quitGameActionSheet
    }
    
    var finishedGameAlert: UIAlertController {
        let alert = UIAlertController(title: "Game Finished", message: "Would you like to submit score to Lederboard?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            let score: Int = Session.manager.score
            if self.instrumentType == .grandPiano {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularGrandPiano)
                GameCenterManager.manager.achievementsManager.reportUnlockAcousticGuitarProgress(with: score)
                GameCenterManager.manager.leaderboardsManager.setPersonalGranPianoHighScore(score: score)
                self.performSegue(withIdentifier: "toLocalProfile2", sender: self)
            }
            else if self.instrumentType == .acousticGuitar {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularAcousticGuitar)
                GameCenterManager.manager.leaderboardsManager.setPersonalAcouGuitarHighScore(score: score)
                GameCenterManager.manager.achievementsManager.reportViolinProgress(with: score)
                self.performSegue(withIdentifier: "toLocalProfile2", sender: self)
            }
            else if self.instrumentType == .violin {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularViolin)
                GameCenterManager.manager.leaderboardsManager.setPersonalViolinHighScore(score: score)
                GameCenterManager.manager.achievementsManager.reportSaxaphoneProgress(with: score)
                self.performSegue(withIdentifier: "toLocalProfile2", sender: self)
            }
            else if self.instrumentType == .saxaphone {
                GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularViolin)
                GameCenterManager.manager.leaderboardsManager.setPersonalViolinHighScore(score: score)
                GameCenterManager.manager.achievementsManager.reportSaxaphoneProgress(with: score)
                self.performSegue(withIdentifier: "toLocalProfile2", sender: self)
            }
        }
        let action2 = UIAlertAction(title: "Discard Round", style: .destructive) { (_) in
                self.performSegue(withIdentifier: "toLocalProfile2", sender: self)
            }
        
        let action3 = UIAlertAction(title: "Replay Round", style: .default) { (_) in
            self.resetGame()
        }
        
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action)
        return alert
    }
    func resetGame() {
        Session.manager.resetScores()
        Session.manager.reuseRound3NoteSet()
        setUpScoresLifes()
        assignNotesToButtons()
        stopPulsingNoteViews()
    }
    //MARK: Outlets
    
    @IBOutlet weak var backgroundGif: UIImageView!

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shuffleSetButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    @IBOutlet weak var note4Button: UIButton!
    @IBOutlet weak var note5Button: UIButton!
    @IBOutlet weak var note6Button: UIButton!
    @IBOutlet weak var note7Button: UIButton!
    @IBOutlet weak var note1ButtonView: UIView!
    @IBOutlet weak var note2ButtonView: UIView!
    @IBOutlet weak var note3ButtonView: UIView!
    @IBOutlet weak var note4ButtonView: UIView!
    @IBOutlet weak var note5ButtonView: UIView!
    @IBOutlet weak var note6ButtonView: UIView!
    @IBOutlet weak var note7ButtonView: UIView!

    lazy var allNoteButtons: [UIButton] = [note1Button,note2Button,note3Button,note4Button,
                                           note5Button,note6Button,note7Button]
    lazy var allNoteViews: [UIView] = [note1ButtonView,note2ButtonView,note3ButtonView,
                                       note4ButtonView,note5ButtonView,note6ButtonView,note7ButtonView]
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

}
