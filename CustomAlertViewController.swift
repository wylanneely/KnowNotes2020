//
//  CustomAlertViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/12/20.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    var instrumentType: InstrumentType = .grandPiano

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsButtons()
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
    func setLabels(instrument: String,score: Int, noteTypes: String){
        
    }
    

    @IBOutlet weak var intrumentTyoeLabel: UIView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var noteChordTypeLabel: UILabel!
    
    
    
    @IBOutlet weak var finishedView: UIView!
    @IBOutlet weak var sendChallengeButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var submitScoreButton: UIButton!
    
    @IBAction func retryTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func sendChallengeTapped(_ sender: Any) {
        
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
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let firstVC = presentingViewController as? GamePlayRound1ViewController {
            firstVC.viewDidAppear(true)
        }
        if let firstVC = presentingViewController as? GamePlayRound2ViewController {
            firstVC.viewDidAppear(true)
        }
        if let firstVC = presentingViewController as? GamePlayRound3ViewController {
            firstVC.viewDidAppear(true)
        }
    }
    
}
