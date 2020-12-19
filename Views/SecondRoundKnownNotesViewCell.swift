//
//  SecondRoundKnownNotesTableViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit


class SecondRoundKnownNotesViewCell: UITableViewCell {
    
    //MARK: Properties
    static let xibRID: String = "SecondRoundKnownNotesViewCell"
    var delegate: secondNoteGroupDelegate?
    var isLocked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUnlockedViews()
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
                self.secondNoteSharpFlat.isHidden = true
                self.eMinorLabel.isHidden = true
                self.dMinorLabel.isHidden = true
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
            self.secondNoteSharpFlat.isHidden = false
            self.secondNoteSharpFlat.startShimmeringAnimation()
        } else {
            self.secondNoteSharpFlat.isHidden = true
        }} else {
            return
        }
    }

    
    func setMinors(){
        if Session.manager.hasHalfNotes {
            self.dMinorLabel.isHidden = false
            self.eMinorLabel.isHidden = false
            self.dMinorLabel.startShimmeringAnimation()
            self.eMinorLabel.startShimmeringAnimation()
        } else {
            self.dMinorLabel.isHidden = true
            self.eMinorLabel.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func createCell() -> SecondRoundKnownNotesViewCell? {
        let nib = UINib(nibName: self.xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? SecondRoundKnownNotesViewCell
           return cell
       }
    
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SecondRoundKnownNotesViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if isLocked {
                delegate?.lockedSecondGroupTapped()
        } else if isLocked == false {
                delegate?.secondGroupTapped()
                setSelectedView()
            }
        }
    
    func setSecondNoteTo(note: String){
        DispatchQueue.main.async {
            self.secondSelectedNoteButton.setTitle(note, for: .normal)
        }
    }
    
    func setSelectedView(){
        DispatchQueue.main.async {
            self.middleBGView.layer.borderColor = UIColor.sharkGreen.cgColor
            self.firstNoteView.layer.borderColor = UIColor.sharkGreen.cgColor
            self.secondSelectedNoteButton.layer.borderColor = UIColor.sharkGreen.cgColor
        }
    }
    
    func setUnlockedViews(){
        middleBGView.layer.borderWidth = 2
        firstNoteView.layer.borderWidth = 2
        secondSelectedNoteButton.layer.borderWidth = 2
        middleBGView.layer.cornerRadius = 10
        firstNoteView.layer.cornerRadius = 10
        secondSelectedNoteButton.layer.cornerRadius = 10
        lockImageView.tintColor = UIColor.clear
        middleBGView.layer.borderColor = UIColor.niceNight.cgColor
        firstNoteView.layer.borderColor = UIColor.niceNight.cgColor
        secondSelectedNoteButton.layer.borderColor = UIColor.niceNight.cgColor
        self.firstSelectedNoteLabel.textColor = UIColor.white
        self.secondSelectedNoteButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    func setLockedNotesViews(){
        isLocked = true
        lockImageView.tintColor = UIColor.roxyClubPurple
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.borderColor = UIColor.lightGray.cgColor
        middleBGView.layer.cornerRadius = 10
        firstNoteView.layer.cornerRadius = 10
        secondSelectedNoteButton.layer.cornerRadius = 10
        firstNoteView.layer.borderWidth = 2
        secondSelectedNoteButton.layer.borderWidth = 2
        firstNoteView.layer.backgroundColor = UIColor.lightGray.cgColor
        secondSelectedNoteButton.layer.backgroundColor = UIColor.lightGray.cgColor
        firstNoteView.layer.borderColor = UIColor.black.cgColor
        secondSelectedNoteButton.layer.borderColor = UIColor.black.cgColor
        secondSelectedNoteButton.setTitleColor(UIColor.darkGray, for: .normal)
        firstSelectedNoteLabel.textColor = UIColor.darkGray
    }
    
    @IBOutlet weak var secondNoteSharpFlat: UILabel!
    @IBOutlet weak var firstNoteView: UIView!
    
    
    @IBOutlet weak var eMinorLabel: UILabel!
    @IBOutlet weak var dMinorLabel: UILabel!
    
    @IBOutlet weak var middleBGView: UIView!
    @IBOutlet weak var firstSelectedNoteLabel: UILabel!
    @IBOutlet weak var secondSelectedNoteButton: UIButton!
    @IBOutlet weak var lockImageView: UIImageView!

}

protocol secondNoteGroupDelegate {
    func secondGroupTapped()
    func lockedSecondGroupTapped()
}
