//
//  ThirdRoundKnownNotesViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/6/20.
//

import UIKit


class ThirdRoundKnownNotesViewCell: UITableViewCell {
    
    //MARK: Properties
    static let xibRID: String = "ThirdRoundKnownNotesViewCell"
    var delegate: ThirdNoteGroupDelegate?
    var isLocked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if isLocked {
            setLockedNotesViews()
        } else {
            setUnlockedViews()
        }
        setGestureRecognizer()
        setInitlAccesoriesViews()
        setSharpsFlats()
    }
    
    func setInitlAccesoriesViews(){
        if Session.manager.currentInstrumentType == .grandPiano {
        setSharpsFlats()
        }
        if Session.manager.currentInstrumentType == .acousticGuitar {
            setMinors()
        }
        else {
                self.firstNoteSharpFlat.isHidden = true
                self.secondNoteSharpFlat.isHidden = true
                self.fMinorLabel.isHidden = true
                self.gMinorLabel.isHidden = true
        }
    }
    
    override func reloadInputViews() {
        if Session.manager.currentInstrumentType == .grandPiano {
        setSharpsFlats()
        }
        if Session.manager.currentInstrumentType == .acousticGuitar {
            setMinors()
        }
    }
    
    func setSharpsFlats(){
        if Session.manager.currentInstrumentType == .grandPiano {

        if Session.manager.hasHalfNotes {
            self.firstNoteSharpFlat.isHidden = false
            self.secondNoteSharpFlat.isHidden = false
            self.firstNoteSharpFlat.startShimmeringAnimation()
            self.secondNoteSharpFlat.startShimmeringAnimation()
        } else {
            self.firstNoteSharpFlat.isHidden = true
            self.secondNoteSharpFlat.isHidden = true
        }} else {
             return 
        }
    }
    
    func setMinors(){
        if Session.manager.hasHalfNotes {
            self.fMinorLabel.isHidden = false
            self.gMinorLabel.isHidden = false
            self.fMinorLabel.startShimmeringAnimation()
            self.gMinorLabel.startShimmeringAnimation()
        } else {
            self.fMinorLabel.isHidden = true
            self.gMinorLabel.isHidden = true
        }
    }
    
    
    
    class func createCell() -> ThirdRoundKnownNotesViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        if localizationLanguage == "Chinese" {
            let cell = nib.instantiate(withOwner: self, options: nil).last as? ThirdRoundKnownNotesViewCell
            return cell
        } else {
            let cell = nib.instantiate(withOwner: self, options: nil).first as? ThirdRoundKnownNotesViewCell
            return cell
        }
    }
    static let localizationLanguage = NSLocalizedString("AppLanguage", comment: "Preffered Language of localization")
    
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ThirdRoundKnownNotesViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if isLocked {
                delegate?.lockedThirdGroupTapped()
            } else {
                setSelectedView()
                delegate?.thirdGroupTapped()
            }
    }
    
    func setSecondNoteTo(note: String){
        DispatchQueue.main.async {
            self.secondSelectedNoteButton.setTitle(note, for: .normal)
        }
    }
    
    func setSelectedView(){
        if SecondRoundKnownNotesViewCell.localizationLanguage == "Chinese" {
            DispatchQueue.main.async {
                self.middleBGView.layer.borderColor = UIColor.chinaYellow.cgColor
                self.firstNoteView.layer.borderColor = UIColor.chinaYellow.cgColor
                self.secondSelectedNoteButton.layer.borderColor = UIColor.chinaYellow.cgColor
            } } else {
                DispatchQueue.main.async {
                    self.middleBGView.layer.borderColor = UIColor.sharkGreen.cgColor
                    self.firstNoteView.layer.borderColor = UIColor.sharkGreen.cgColor
                    self.secondSelectedNoteButton.layer.borderColor = UIColor.sharkGreen.cgColor
                } }
    }
    
    func setUnlockedViews(){
        middleBGView.layer.borderWidth = 2
        firstNoteView.layer.borderWidth = 2
        secondSelectedNoteButton.layer.borderWidth = 2
        middleBGView.layer.cornerRadius = 10
        firstNoteView.layer.cornerRadius = 10
        secondSelectedNoteButton.layer.cornerRadius = 10
        lockImageView.tintColor = UIColor.clear
        if ThirdRoundKnownNotesViewCell.localizationLanguage == "Chinese" {
            self.firstSelectedNoteLabel.textColor = UIColor.black
            self.secondSelectedNoteButton.setTitleColor(UIColor.black, for: .normal)
            middleBGView.layer.borderColor = UIColor.white.cgColor
            firstNoteView.layer.borderColor = UIColor.white.cgColor
            secondSelectedNoteButton.layer.borderColor = UIColor.white.cgColor
        } else {
            self.firstSelectedNoteLabel.textColor = UIColor.white
            self.secondSelectedNoteButton.setTitleColor(UIColor.white, for: .normal)
            middleBGView.layer.borderColor = UIColor.niceNight.cgColor
            firstNoteView.layer.borderColor = UIColor.niceNight.cgColor
            secondSelectedNoteButton.layer.borderColor = UIColor.niceNight.cgColor
        }
    }
    
    func setLockedNotesViews(){
        isLocked = true
        if ThirdRoundKnownNotesViewCell.localizationLanguage == "Chinese" {
            middleBGView.layer.borderColor = UIColor.white.cgColor
            lockImageView.tintColor = UIColor.chinaYellow
            firstNoteView.layer.backgroundColor = UIColor.lightGray.cgColor
            secondSelectedNoteButton.layer.backgroundColor = UIColor.lightGray.cgColor
            secondSelectedNoteButton.layer.borderColor = UIColor.black.cgColor
            secondSelectedNoteButton.setTitleColor(UIColor.darkGray, for: .normal)
            firstNoteView.layer.borderColor = UIColor.black.cgColor
            secondSelectedNoteButton.layer.borderColor = UIColor.black.cgColor
            secondSelectedNoteButton.setTitleColor(UIColor.darkGray, for: .normal)
            firstSelectedNoteLabel.textColor = UIColor.darkGray
        } else {
            middleBGView.layer.borderColor = UIColor.lightGray.cgColor
            lockImageView.tintColor = UIColor.roxyClubPurple
            firstNoteView.layer.backgroundColor = UIColor.lightGray.cgColor
            secondSelectedNoteButton.layer.backgroundColor = UIColor.lightGray.cgColor
            secondSelectedNoteButton.layer.borderColor = UIColor.black.cgColor
            secondSelectedNoteButton.setTitleColor(UIColor.darkGray, for: .normal)
            firstNoteView.layer.borderColor = UIColor.black.cgColor
            secondSelectedNoteButton.layer.borderColor = UIColor.black.cgColor
            secondSelectedNoteButton.setTitleColor(UIColor.darkGray, for: .normal)
            firstSelectedNoteLabel.textColor = UIColor.darkGray
        }
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.cornerRadius = 10
        firstNoteView.layer.cornerRadius = 10
        secondSelectedNoteButton.layer.cornerRadius = 10
        firstNoteView.layer.borderWidth = 2
        secondSelectedNoteButton.layer.borderWidth = 2
    }
    
    @IBAction func secondNoteButtonTapped(_ sender: Any) {
        if isLocked {
                setSelectedView()
                delegate?.lockedThirdGroupTapped()
            } else {
                setSelectedView()
                delegate?.thirdGroupTapped()
            }
    }
    
    @IBOutlet weak var firstNoteSharpFlat: UILabel!
    @IBOutlet weak var secondNoteSharpFlat: UILabel!
    
    @IBOutlet weak var gMinorLabel: UILabel!
    @IBOutlet weak var fMinorLabel: UILabel!
    
    
    @IBOutlet weak var firstNoteView: UIView!
    @IBOutlet weak var middleBGView: UIView!
    @IBOutlet weak var firstSelectedNoteLabel: UILabel!
    @IBOutlet weak var secondSelectedNoteButton: UIButton!
    @IBOutlet weak var lockImageView: UIImageView!
    
}

protocol ThirdNoteGroupDelegate {
    func thirdGroupTapped()
    func lockedThirdGroupTapped()
}
