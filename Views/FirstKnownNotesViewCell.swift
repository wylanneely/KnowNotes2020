//
//  FirstKownNotesViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class FirstKnownNotesViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUPViews()
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
            self.flatLabel.isHidden = true
            self.sharpLabel.isHidden = true
            self.aMinorLabel.isHidden = true
            self.bMinorLabel.isHidden = true
            self.cMinorLabel.isHidden = true
        }
    }
    
    override func reloadInputViews() {
        if Session.manager.currentInstrumentType == .grandPiano {
        setSharpsFlats()
        }
        if Session.manager.currentInstrumentType == .acousticGuitar {
            setMinors()
        }    }
    
    func setSharpsFlats(){
        if Session.manager.currentInstrumentType == .grandPiano {
        if Session.manager.hasHalfNotes {
            self.flatLabel.isHidden = false
            self.flatLabel.startShimmeringAnimation()
            self.sharpLabel.isHidden = false
            self.sharpLabel.startShimmeringAnimation()
        } else {
                self.flatLabel.isHidden = true
                self.sharpLabel.isHidden = true
        }} else {
            return
        }
    }
    
    func setMinors(){
        if Session.manager.hasHalfNotes {
            self.aMinorLabel.isHidden = false
            self.bMinorLabel.isHidden = false
            self.cMinorLabel.isHidden = false
            self.aMinorLabel.startShimmeringAnimation()
            self.bMinorLabel.startShimmeringAnimation()
            self.cMinorLabel.startShimmeringAnimation()
        } else {
            self.aMinorLabel.isHidden = true
            self.bMinorLabel.isHidden = true
            self.cMinorLabel.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstKnownNotesViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        delegate?.firstGroupTapped()
    }
    
    func setSelectedView(){
        DispatchQueue.main.async {
            self.middleBGView.layer.borderColor = UIColor.sharkGreen.cgColor
            self.note1Button.layer.borderColor = UIColor.sharkGreen.cgColor
            self.note2Button.layer.borderColor = UIColor.sharkGreen.cgColor
            self.note3Button.layer.borderColor = UIColor.sharkGreen.cgColor
        }
    }
    
    //MARK:Properties
    
    
    func setUPViews(){
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.borderColor = UIColor.niceNight.cgColor
        middleBGView.layer.cornerRadius = 10
        note1Button.layer.cornerRadius = 10
        note2Button.layer.cornerRadius = 10
        note3Button.layer.cornerRadius = 10
        note1Button.layer.borderWidth = 2
        note2Button.layer.borderWidth = 2
        note3Button.layer.borderWidth = 2
        note1Button.layer.borderColor = UIColor.niceNight.cgColor
        note2Button.layer.borderColor = UIColor.niceNight.cgColor
        note3Button.layer.borderColor = UIColor.niceNight.cgColor
    }
    
    class func createCell() -> FirstKnownNotesViewCell? {
        let nib = UINib(nibName: self.xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? FirstKnownNotesViewCell
        return cell
    }
    
    static let xibRID: String = "FirstKnownNotesViewCell"
    
    var delegate: FirstRoundNotesDelegate?
    
//    func animateSharps(){
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 2.5) {
//                self.flatLabel.textColor = UIColor.red
//                self.sharpLabel.textColor = UIColor.red
//            } completion: {
//                (completed: Bool) -> Void in
//                UIView.animateKeyframes(withDuration: 2.5, delay: 1, options: .repeat) {
//                    self.flatLabel.textColor = UIColor.white
//                        self.sharpLabel.textColor = UIColor.white
//                } completion: { (completed: Bool) -> Void in
//                    self.flatLabel.textColor = UIColor.red
//                    self.sharpLabel.textColor = UIColor.red
//                }
//            }
//        }
//        }

    //MARK: Outlets
    
    
    @IBOutlet weak var aMinorLabel: UILabel!
    @IBOutlet weak var bMinorLabel: UILabel!
    @IBOutlet weak var cMinorLabel: UILabel!
    
    
    @IBOutlet weak var flatLabel: UILabel!
    @IBOutlet weak var sharpLabel: UILabel!
    @IBOutlet weak var middleBGView: UIView!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!

}

protocol FirstRoundNotesDelegate {
    func firstGroupTapped()
}

