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
            }
            includesHalfNotes = true
        } else {
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
                self.delegate?.sharpsFlatsSelected(hasHalfs: true)
            }
            includesHalfNotes = false
        }
    }
    
    class func createCell() -> HalfNotesLockedViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? HalfNotesLockedViewCell
        return cell
    }
    
 
    
    func setImage(){
        
        if isLocked == false {
            self.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
            }
        }
    }
    
    func setGUitarChords(){
        DispatchQueue.main.async {
            self.notesLabel.text = "Add Minor Chords"
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

