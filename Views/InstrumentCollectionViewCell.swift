//
//  InstrumentCollectionViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/18/20.
//

import UIKit


class InstrumentCollectionViewCell: UICollectionViewCell {
    
    var instrumentType: InstrumentType = .grandPiano
    let leaderboardManager = GameCenterManager.manager.leaderboardsManager
    var isLocked: Bool = true
    
     var delegate: InstrumentCollectionCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        instrumentLabel.text = instrumentType.rawValue
        instrumentLabel.text = nil
        instrumentButton.setTitle("  Play  ", for: .normal)
        instrumentButton.layer.backgroundColor = UIColor.discoDayGReen.cgColor
        
//        switch instrumentType {
//        case .grandPiano:
//            let score = leaderboardManager.getHighScoreGrandPiano()
//            highScoreLabel.text = "High Score: \(score)"
//        case .acousticGuitar:
//            let score = leaderboardManager.highScoreAcousticGuitar()
//            highScoreLabel.text = "High Score: \(score)"
//        case .violin:
//            let score = leaderboardManager.highScoreViolin()
//            highScoreLabel.text = "High Score: \(score)"
//        case .saxaphone:
//            let score = leaderboardManager.highScoreSax()
//            highScoreLabel.text = "High Score: \(score)"
//        }
    }
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentButton: UIButton!
    @IBOutlet weak var instrumentLabel: UILabel!
    
    @IBOutlet weak var notesUnlockedLabel: UILabel!
    
    @IBAction func instrumentButtonTapped(_ sender: Any) {
        delegate?.instrumentCellButtonTapped(type: self.instrumentType)
    }
    
    func setUp(type: InstrumentType, isUnlocked: Bool){
        
        self.isLocked = !isUnlocked

        instrumentButton.setTitle("  Play  ", for: .normal)
        switch type {
        case .grandPiano:
            self.instrumentType = type
            instrumentLabel.text = instrumentType.rawValue
            instrumentImage.image = UIImage.ImageWithName(name: "grand_Piano")
            setLockedState()
            let score = leaderboardManager.getHighScoreGrandPiano()
           // highScoreLabel.text = "High Score: \(score)"
            if leaderboardManager.didFinishGrandPianoRound1 == true {
                notesUnlockedLabel.text = "5 Notes Unlocked"
            }else {
                notesUnlockedLabel.text = "3 Chords Unlocked"
            }
            if leaderboardManager.didFinishGrandPianoRound2 == true {
                notesUnlockedLabel.text = "7 Notes Unlocked"
            }
        case .acousticGuitar:
            self.instrumentType = type
            instrumentLabel.text = "Acoustic Guitar"
            instrumentImage.image = UIImage.ImageWithName(name: "acoustic_Guitar")
            setLockedState()
            let score = leaderboardManager.highScoreAcousticGuitar()
          //  highScoreLabel.text = "High Score: \(score)"
            if leaderboardManager.didFinishAcousticGuitarRound1 == true {
                notesUnlockedLabel.text = "5 Chords Unlocked"
            } else {
                notesUnlockedLabel.text = "3 Chords Unlocked"
            }
            if leaderboardManager.didFinishAcousticGuitarRound2 == true {
                notesUnlockedLabel.text = "7 Notes Unlocked"
            }
        case .violin:
            self.instrumentType = type
            setLockedState()
            instrumentLabel.text = "Violin"
            instrumentImage.image = UIImage.ImageWithName(name: "violin")
            let score = leaderboardManager.highScoreViolin()
          //  highScoreLabel.text = "High Score: \(score)"
            if leaderboardManager.didFinishViolinRound1 == true {
                notesUnlockedLabel.text = "5 Notes Unlocked"
            }
            if leaderboardManager.didFinishViolinRound2 == true {
                notesUnlockedLabel.text = "7 Notes Unlocked" }
        
        case .saxaphone:
            self.instrumentType = type
            setLockedState()
            instrumentLabel.text = "Saxophone"
            instrumentImage.image = UIImage.ImageWithName(name: "saxophone")
            let score = leaderboardManager.highScoreSax()
           // highScoreLabel.text = "High Score: \(score)"//
            
            
            if leaderboardManager.didFinishSaxRound1 == true {
                notesUnlockedLabel.text = "5 Notes Unlocked"
            }
            if leaderboardManager.didFinishSaxRound2 == true {
                notesUnlockedLabel.text = "7 Notes Unlocked" }
        
        }
    }
    
    func setLockedState(){
        instrumentButton.layer.cornerRadius = 10
        backgroundColorView.layer.cornerRadius = 10
        backgroundColorView.layer.masksToBounds = true
        backgroundColorView.layer.borderWidth = 2
        instrumentButton.layer.borderWidth = 2
        if isLocked {
            instrumentLabel.textColor = UIColor.darkGray
            instrumentButton.setTitle("Locked", for: .normal)
            instrumentButton.setTitleColor(.white, for: .normal)
            instrumentButton.layer.backgroundColor = UIColor.darkGray.cgColor
            instrumentButton.layer.borderColor = UIColor.imperialRed.cgColor
            backgroundColorView.layer.backgroundColor = UIColor.lightGray.cgColor
            backgroundColorView.layer.borderColor = UIColor.imperialRed.cgColor
        } else {
            backgroundColorView.layer.backgroundColor = self.returnInstrumentColor().cgColor
            backgroundColorView.layer.borderColor = UIColor.discoDayGReen.cgColor
            instrumentButton.setTitleColor(UIColor.black, for: .normal)
            instrumentButton.layer.borderColor = UIColor.midnightPurps.cgColor
            instrumentButton.pulsate()
        }
    }
    
    private func returnInstrumentColor()-> UIColor {
        switch self.instrumentType {
        case .acousticGuitar:
            switch leaderboardManager.acousticGuitarLevel() {
            case 0:
                return UIColor.greenLandOcean
            case 1:
               return UIColor.polarCapBlue
            case 2:
                return UIColor.roxyClubPurple
            default:
                return UIColor.greenLandOcean
            }
        case .grandPiano:
            switch leaderboardManager.pianoLevel() {
            case 0:
                return UIColor.greenLandOcean
            case 1:
               return UIColor.polarCapBlue
            case 2:
                return UIColor.roxyClubPurple
            default:
                return UIColor.greenLandOcean
            }
        case .violin:
            switch leaderboardManager.violinLevel() {
            case 0:
                return UIColor.greenLandOcean
            case 1:
               return UIColor.polarCapBlue
            case 2:
                return UIColor.roxyClubPurple
            default:
                return UIColor.greenLandOcean
            }
        case .saxaphone:
            switch leaderboardManager.saxaphoneLevel() {
            case 0:
                return UIColor.greenLandOcean
            case 1:
               return UIColor.polarCapBlue
            case 2:
                return UIColor.roxyClubPurple
            default:
                return UIColor.greenLandOcean
            }
        }
    }
    
    
}

protocol InstrumentCollectionCellDelegate {
    func instrumentCellButtonTapped(type: InstrumentType)
}
