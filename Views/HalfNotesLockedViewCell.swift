//
//  HalfNotesLockedViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class HalfNotesLockedViewCell: UITableViewCell {
    
    var isLocked: Bool {
      return  !Session.manager.isHalfNotesUnLocked
    }
    
    var delegate: sharpsFlatsDelegate?
    var includesHalfNotes: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setGestureRecognizer()
        setImage()
        if Session.manager.currentInstrumentType == .grandPiano {
            setPianoNotes()
        }
        if Session.manager.currentInstrumentType == .acousticGuitar {
            setGUitarChords()
        }
    }

    func setUpViews(){
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        borderView.layer.cornerRadius = 10
    }
    
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HalfNotesLockedViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if isLocked {
            self.delegate?.sharpsFlatsSelected(hasHalfs: nil)
            return
        }
        if includesHalfNotes == false {
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"checkmark.rectangle.fill")
                self.delegate?.sharpsFlatsSelected(hasHalfs: true)
                 Session.manager.hasHalfNotes = true
            }
            includesHalfNotes = true
        } else {
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
                self.delegate?.sharpsFlatsSelected(hasHalfs: false)
                 Session.manager.hasHalfNotes = false
            }
            includesHalfNotes = false
        }
    }
    
    class func createCell() -> HalfNotesLockedViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? HalfNotesLockedViewCell
        return cell
    }
    
    func setLockedState(){
        borderView.layer.backgroundColor = UIColor.beauBlue.cgColor
        borderView.layer.borderColor = UIColor.lightGray.cgColor
    }
    func setUnlockedState(){
        borderView.layer.backgroundColor = UIColor.clear.cgColor
        borderView.layer.borderColor = UIColor.seaFoamBlue.cgColor
    }
    
    func setImage(){
        if isLocked == true {
            setLockedState()
            self.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"lock.fill")
            }
            return
        } else {
        setUnlockedState()
        }
        if includesHalfNotes == true {
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"checkmark.rectangle.fill")
            }
        }else {
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
                self.delegate?.sharpsFlatsSelected(hasHalfs: false)
                Session.manager.hasHalfNotes = false
            }
        }
    }
    let addSF = NSLocalizedString("Add Sharps/Flats", comment: "none")
    let addMinorC = NSLocalizedString("Add Minor Chords", comment: "none")

    
    func setPianoNotes() {
        DispatchQueue.main.async {
            self.notesLabel.text = self.addSF
        }
    }
    
    func setGUitarChords(){
        DispatchQueue.main.async {
            self.notesLabel.text = self.addMinorC
        }
    }
    
    @IBOutlet weak var lockedOrChecked: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var notesLabel: UILabel!
    
    static let xibRID:String = "HalfNotesLockedViewCell"
}

protocol sharpsFlatsDelegate {
    func sharpsFlatsSelected(hasHalfs: Bool?)
}

