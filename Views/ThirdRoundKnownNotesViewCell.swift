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
        setUnlockedViews()
        setGestureRecognizer()
        setSharpsFlats()
    }
    
    override func reloadInputViews() {
        setSharpsFlats()
    }
    
    func setSharpsFlats(){
        if Session.manager.hasHalfNotes {
            self.firstNoteSharpFlat.isHidden = false
            self.secondNoteSharpFlat.isHidden = false
            self.firstNoteSharpFlat.startShimmeringAnimation()
            self.secondNoteSharpFlat.startShimmeringAnimation()
        } else {
            self.firstNoteSharpFlat.isHidden = true
            self.secondNoteSharpFlat.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func createCell() -> ThirdRoundKnownNotesViewCell? {
        let nib = UINib(nibName: self.xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? ThirdRoundKnownNotesViewCell
        return cell
        
       }
    
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ThirdRoundKnownNotesViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if isLocked {
                setSelectedView()
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
    
    
    @IBOutlet weak var firstNoteSharpFlat: UILabel!
    @IBOutlet weak var secondNoteSharpFlat: UILabel!
    
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
