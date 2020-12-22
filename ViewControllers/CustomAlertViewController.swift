//
//  CustomAlertViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/12/20.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    var instrumentType: InstrumentType {
        return Session.manager.currentInstrumentType
    }
    
    var isUsingHalfs: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsButtons()
        setLabels()
        // Do any additional setup after loading the view.
    }
    func setUpViewsButtons(){
        finishedView.layer.cornerRadius = 10
        sendChallengeButton.layer.cornerRadius = 10
        retryButton.layer.cornerRadius = 10
        submitScoreButton.layer.cornerRadius = 10
        sendChallengeButton.layer.borderWidth = 2
        sendChallengeButton.layer.borderColor = UIColor.white.cgColor
        retryButton.layer.borderWidth = 2
        retryButton.layer.borderColor = UIColor.discoDayGReen.cgColor
        submitScoreButton.layer.borderWidth = 2
        submitScoreButton.layer.borderColor = UIColor.black.cgColor
    }
    func setLabels(){
        let instrument = getInstrumentType()
        let score = scoreStr + ": \(Session.manager.score)"
        var noteTypes = regularNotesStr
        if instrumentType == .grandPiano {
            if isUsingHalfs {
                noteTypes = regularShrFltStr
            } else {
                noteTypes = regulrWhole
            }

        } else if instrumentType == .acousticGuitar {
            if isUsingHalfs {
            noteTypes = MajMinChordStr
            } else {
                noteTypes = majChordStr
            }
        }
        
        intrumentTypeLabel.text = instrument
        scoreLabel.text = score
        noteChordTypeLabel.text = noteTypes
    }
    
    
    
    func getInstrumentType()-> String{
        switch instrumentType {
        case .grandPiano:
            return grandPianoT
        case .acousticGuitar:
            return acousticGuitarT
        case .violin:
            return violinT
        case .saxaphone:
            return saxT
        }
    }
    
    //MARK: Localization Language
    
    private let grandPianoT = NSLocalizedString("Grand Piano", comment: "none")
    private let acousticGuitarT = NSLocalizedString("Acoustic Guitar", comment: "none")
    private let violinT = NSLocalizedString("Violin", comment: "none")
    private let saxT = NSLocalizedString("Saxophone", comment: "none")
    private let majChordStr = NSLocalizedString("Major Chords", comment: "none")
    private let MajMinChordStr = NSLocalizedString("Major & Minor Chords", comment: "none")
    private let submitScoreTitle = NSLocalizedString("Submit Score", comment: "none")
    private let regularNotesStr = NSLocalizedString("Regular Notes", comment: "none")
    private let regularShrFltStr = NSLocalizedString("Regular + Sharp & Flats", comment: "none")
    private let regulrWhole = NSLocalizedString("Regular Whole Notes", comment: "none")
    private let scoreStr = NSLocalizedString("Score", comment: "none")

    @IBOutlet weak var intrumentTypeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var noteChordTypeLabel: UILabel!
    
    @IBOutlet weak var finishedView: UIView!
    @IBOutlet weak var sendChallengeButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var submitScoreButton: UIButton!
    
    @IBAction func retryTapped(_ sender: Any) {
        
        self.viewWillDisappear(true)
        self.dismiss(animated: true) {
        }
    }
    @IBAction func sendChallengeTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "backMainSegue", sender: self)
    }
    @IBAction func submitScoreTapped(_ sender: Any) {
        
        let score: Int = Session.manager.score
        if self.instrumentType == .grandPiano {
            GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularGrandPiano)
            GameCenterManager.manager.leaderboardsManager.setPersonalGranPianoHighScore(score: score)
        } else if self.instrumentType == .acousticGuitar {
            GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularAcousticGuitar)
            GameCenterManager.manager.leaderboardsManager.setPersonalAcouGuitarHighScore(score: score)
        }
        else if self.instrumentType == .violin {
            GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularViolin)
            GameCenterManager.manager.leaderboardsManager.setPersonalViolinHighScore(score: score)
        }
        else if self.instrumentType == .saxaphone {
            GameCenterManager.manager.leaderboardsManager.submit(score: score, to: .regularSaxaphone)
            GameCenterManager.manager.leaderboardsManager.setPersonalSaxaphoneHighScore(score: score)
        }
     }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let firstVC = presentingViewController as? GamePlayRound1ViewController {
            firstVC.resetGame()
            firstVC.viewDidAppear(true)
        }
        if let secondVC = presentingViewController as? GamePlayRound2ViewController {
            secondVC.resetGame()
            secondVC.viewDidAppear(true)
        }
        if let thirdVC = presentingViewController as? GamePlayRound3ViewController {
            thirdVC.resetGame()
            thirdVC.viewDidAppear(true)
        }
    }
    
}
