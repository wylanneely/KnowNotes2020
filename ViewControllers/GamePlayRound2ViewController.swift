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
    let hapticGenerator = UINotificationFeedbackGenerator()
    var musicSound: AVAudioPlayer?
    
    var doesGameNeedNewNote: Bool = true
    
    var gameRoundNotes: [Note] {
            return Session.manager.sessionNotes
        }
    var score: Int { Session.manager.score }

    
    var currentNote: Note?

    var note1: Note?
    var note2: Note?
    var note3: Note?
    var note4: Note?
    var note5: Note?
    
    lazy var noteSet: [Note?] = [note1,note2,note3,note4,note5]

    
    //AdvancedOptions 
    var hasHalfNotes: Bool {
        return Session.manager.hasHalfNotes
    }
    var shuffleMode: ShuffleMode = .off

    //for progressView
    var isStartingRound: Bool = false
    
    let totalGroupRounds: Double = 15.00
    var currentRound: Double = 1.00
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignNotesToButtons()
        setUpLabelsButtonsViews()
        self.isModalInPresentation = true
        setUpGif()
        self.updateLifesGif()
        playButton.pulse()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.async {
            self.setUpLabelsButtonsViews()
        }
        
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
    
    
    func setUpGif(){
        circleProgressBar.labelSize = 60
        circleProgressBar.safePercent = 100
        circleProgressBar.lineWidth = 12
        circleProgressBar.safePercent = 100
        circleProgressBar.layer.backgroundColor = UIColor.gameplayBlue.cgColor
        circleProgressBar.layer.cornerRadius = circleProgressBar.frame.size.width/2
        circleProgressBar.clipsToBounds = true
        view.sendSubviewToBack(circleProgressBar)
    }
    
    func getGameNotes(){
        doesGameNeedNewNote = true
        if hasHalfNotes{
            Session.manager.setRound2HalfNotes { (_) in
                self.assignNotesToButtons()
            }
        } else {
            Session.manager.setRound2Notes { (_) in
                self.assignNotesToButtons()
            }
        }
    }
    
    func assignNotesToButtons(){
        DispatchQueue.main.async {
            let note_1 = self.gameRoundNotes[0]
            let note_2 = self.gameRoundNotes[1]
            let note_3 = self.gameRoundNotes[2]
            let note_4 = self.gameRoundNotes[3]
            let note_5 = self.gameRoundNotes[4]
            self.note1 = note_1
            self.note2 = note_2
            self.note3 = note_3
            self.note4 = note_4
            self.note5 = note_5
            self.note1Button.tag = note_1.id
            self.note2Button.tag = note_2.id
            self.note3Button.tag = note_3.id
            self.note4Button.tag = note_4.id
            self.note5Button.tag = note_5.id
            self.note1Button.setTitle("\(note_1.name)", for: .normal)
            self.note2Button.setTitle("\(note_2.name)", for: .normal)
            self.note3Button.setTitle("\(note_3.name)", for: .normal)
            self.note4Button.setTitle("\(note_4.name)", for: .normal)
            self.note5Button.setTitle("\(note_5.name)", for: .normal)
          self.noteSet = [self.note1,self.note2,self.note3,self.note4,self.note5]
        }
    }
    
    func setUpLabelsButtonsViews(){
        playButton.layer.cornerRadius = 10
        shuffleSetButton.layer.cornerRadius = 10
        shuffleSetButton.layer.borderWidth = 2
        shuffleSetButton.layer.borderColor = UIColor.discoDayGReen.cgColor
        DispatchQueue.main.async {
            self.scoreLabel.text = "\(Session.manager.score)"
            self.playButton.setTitle(self.playTitle, for: .normal)
            self.playButton.pulse()
        }
        if language == "Chinese" {
            if UIDevice.modelName.contains("iPhone SE"){
                lilfesLabel.textColor = UIColor.chinaRed
            } else {
                lilfesLabel.textColor = UIColor.chinaYellow
            }
            scoreLabel.textColor = UIColor.chinaRed
            self.view.backgroundColor = UIColor.chinaYellow
            circleProgressBar.backgroundColor = UIColor.chinaYellow
            playButton.backgroundColor = UIColor.chinaRed
            leaveButton.setTitleColor(.black, for: .normal)
            scoreTitle.textColor = UIColor.chinaRed
        }
    }
    
    func byPassSilentMode(){
        do {
              try AVAudioSession.sharedInstance().setCategory(.playback)
           } catch(let error) {
               print(error.localizedDescription)
           }
    }
    
    
    //MARK: Update Functions
    
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
                    if self.language == "Chinese" {
                        self.view.backgroundColor = UIColor.chinaYellow
                    } else {
                    self.view.backgroundColor = UIColor.gameplayBlue
                    }
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
                    if self.language == "Chinese" {
                        self.view.backgroundColor = UIColor.chinaYellow
                    } else {
                    self.view.backgroundColor = UIColor.gameplayBlue
                    }
                    self.playButton.pulse()
                }  }
    }
    
    fileprivate func updateViewsWithCorrectAnswer(){
        DispatchQueue.main.async {
            self.playButton.setTitle(self.playTitle, for: .normal)
            self.scoreLabel.text = "\(Session.manager.score)"
            self.updateProgressBar()
            self.handleCorrectAnswerWithHaptic()
        }
        doesGameNeedNewNote = true
    }
    
    fileprivate func updateViewsWithIncorrectAnswer(noteButton: UIButton) {
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
        else if noteButton == note4Button {
            self.note4Button.layer.removeAllAnimations()
            self.note4ButtonView.layer.removeAllAnimations()
            self.note4Button.isEnabled = false
        } else if noteButton == note5Button {
            self.note5Button.layer.removeAllAnimations()
            self.note5ButtonView.layer.removeAllAnimations()
            self.note5Button.isEnabled = false
        }
        handleWrongAnswerWithHaptic()
        DispatchQueue.main.async {
            self.updateLifesGif()
        }
    }
   
    
    //MARK: Language Localiation
    private let finishedTitle = NSLocalizedString("Finished", comment: "none")
    private var language: String = NSLocalizedString("AppLanguage", comment: "to help adjust certain views/settings")
    private let quitMessage = NSLocalizedString("QuitMessage", comment: "none")
    private let quitGTitle = NSLocalizedString("Quit Game?", comment: "none")
    let playTitle = NSLocalizedString("Play", comment: "none")
    let keepTitle = NSLocalizedString("Keep", comment: "none")
    let repeatTitle = NSLocalizedString("Repeat", comment: "none")
    let yesTitle = NSLocalizedString("Yes", comment: "none")
    let noTitle = NSLocalizedString("No", comment: "none")
    
    func updateLifesGif(){
        let lifesLeft = Session.manager.lifes
        lilfesLabel.text = "\(lifesLeft)"
        var gifname = ""
        if language == "Chinese" {
            gifname = "chinaKnowNotes\(lifesLeft)Lifes"
        } else {
            gifname = "knowNotes\(lifesLeft)Lifes"
        }
        DispatchQueue.main.async {
            let gifImage = UIImage.gifImageWithName(name: gifname)
            self.backgroundGif.image = gifImage
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
                Session.manager.reuseRound2NoteSet()
            default:
                Session.manager.reuseRound2NoteSet()
            }
        }
    }
    
    func shuffleNotes(){
        doesGameNeedNewNote = true
        if hasHalfNotes{
            Session.manager.setRound2HalfNotes { (_) in
                self.assignNotesToButtons()
            }
        } else {
            Session.manager.shuffleRound2Notes { (_) in
                Session.manager.reuseRound2NoteSet()
                self.assignNotesToButtons()
            }
        }
    }
    
    func showShuffleButtonModes(){
        DispatchQueue.main.async {
            self.shuffleSetButton.isHidden = false
            self.shuffleSetButton.isUserInteractionEnabled = true
            self.shuffleSetButton.pulse()
            self.playButton.setTitle(self.keepTitle, for: .normal)
        }
    }
    
    func hideShuffleButton(){
        shuffleSetButton.isHidden = true
        shuffleSetButton.isUserInteractionEnabled = false
    }

    
    //MARK: Actions
    @IBAction func leaveButtonTapped(_ sender: Any) {
        self.present(quitGameActionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func playButtonTapped(_ sender: Any) {
        if playButton.title(for: .normal) == keepTitle {
            Session.manager.reuseRound2NoteSet()
            DispatchQueue.main.async {
                self.playButton.setTitle(self.playTitle, for: .normal)
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
                self.playButton.setTitle(self.repeatTitle, for: .normal)
                self.pulseAllNoteButtons()
            }
        } else {
            playSoundFromNote(path: currentNote?.soundPath)
        }
    }
    
    @IBAction func shuffleNotes(_ sender: Any) {
        DispatchQueue.main.async {
                self.shuffleNotes()
            self.hideShuffleButton()
            self.playButton.setTitle(self.playTitle, for: .normal)
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
                updateViewsWithIncorrectAnswer(noteButton: note1Button)

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
                updateViewsWithIncorrectAnswer(noteButton: note2Button)
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
                updateViewsWithIncorrectAnswer(noteButton: note3Button)
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
                updateViewsWithIncorrectAnswer(noteButton: note4Button)
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
                updateViewsWithIncorrectAnswer(noteButton: note5Button)
            }
        }
        checkRoundEnd()
    }
    
    //MARK: Helper Functions
    
    func updateProgressBar(){
        let progress = currentRound/totalGroupRounds
        circleProgressBar.setProgress(to: progress , withAnimation: false)
        self.currentRound = currentRound + 1.0
    }
    
    func checkRoundEnd(){
        if isStartingRound {
            if Session.manager.score >= 15 {
                self.performSegue(withIdentifier: "toRound3", sender: self) }
            if Session.manager.lifes == 0 {
                self.performSegue(withIdentifier: "round2Finish", sender: self)
            }
        } else {
            if Session.manager.score >= 25 {
                self.performSegue(withIdentifier: "toRound3", sender: self)
            }
            if Session.manager.lifes == 0 {
                self.performSegue(withIdentifier: "round2Finish", sender: self)
                    //Possible unwind segue area
                 }
        } }
    
    func resetGame() {
        currentRound = 2.0
        Session.manager.resetScores()
        Session.manager.reuseRound2NoteSet()
        setUpLabelsButtonsViews()
        stopPulsingNoteViews()
            circleProgressBar.setProgress(to: 0 , withAnimation: true)
    }
    //MARK: Alerts
 
    var quitGameActionSheet: UIAlertController {
        let quitGameActionSheet = UIAlertController(title: quitGTitle, message: quitMessage, preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: yesTitle, style: .destructive) { (_) in
            self.isModalInPresentation = false
            self.performSegue(withIdentifier: "toLocalProfile", sender: self)
        }
        let noAction = UIAlertAction(title:noTitle, style: .cancel) { (_) in
            return
        }
        quitGameActionSheet.addAction(noAction)
        quitGameActionSheet.addAction(yesAction)
        return quitGameActionSheet
    }
    
    
    
    //MARK: Outlets
    
    @IBOutlet weak var backgroundGif: UIImageView!
    @IBOutlet weak var circleProgressBar: CircularProgressBar!
    
    @IBOutlet weak var lilfesLabel: UILabel!
    
    @IBOutlet weak var scoreTitle: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var shuffleSetButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
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
    
    @IBOutlet weak var leaveButton: UIButton!

    
    
    lazy var allNoteButtons: [UIButton] = [note1Button,note2Button,note3Button,note4Button,note5Button]
    
    lazy var allNoteViews: [UIView] = [note1ButtonView,note2ButtonView,note3ButtonView,note4ButtonView,note5ButtonView]
    
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
        if segue.identifier == "toRound3" {
            if let vc = segue.destination as?
                GamePlayRound3ViewController {
                
                vc.instrumentType = self.instrumentType
                if Session.manager.hasHalfNotes{
                    Session.manager.setRound3HalfNotes { (_) in
                    }
                } else {
                    Session.manager.setRound3Notes { (_) in
                    }
                }
                
                if instrumentType == .grandPiano {
                    GameCenterManager.manager.leaderboardsManager.finishedRound2GrandPianoNotes()
                } else if instrumentType == .acousticGuitar {
                    GameCenterManager.manager.leaderboardsManager.finishedRound2AcousticGuitarNotes()
                } else if instrumentType == .violin {
                    GameCenterManager.manager.leaderboardsManager.finishedRound2ViolinNotes()
                } else if instrumentType == .saxaphone {
                    GameCenterManager.manager.leaderboardsManager.finishedRound2SaxNotes()
                }
            }
        }
    }
    

}
