//
//  CustomRoundsViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/14/20.
//

import UIKit

class CustomRoundsViewCell: UITableViewCell {
    
    var isLocked: Bool {
      return  Session.manager.isCustomModeLocked
    }
    
    var delegate: CustomRoundsDelegate?
    var isCustom: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setGestureRecognizer()
        setImage()
        setNotesLabelLanguage()
    }
    
    func setUpViews(){
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.middlePurple.cgColor
        borderView.layer.cornerRadius = 10
    }
    
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CustomRoundsViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if isLocked {
            self.delegate?.customRoundsSelected(isCustom: nil)
            return
        }
//        if isCustom == false {
//            DispatchQueue.main.async {
//                self.lockedOrChecked.image = UIImage.init(systemName:"checkmark.rectangle.fill")
//                self.delegate?.customRoundsSelected(isCustom: true)
//                Session.manager.isCustomSession = true
//            }
//            isCustom = true
//        } else {
//            DispatchQueue.main.async {
//                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
//                self.delegate?.customRoundsSelected(isCustom: false)
//                Session.manager.isCustomSession = false
//            }
//            isCustom = false
//        }
    }
    
    class func createCell() -> CustomRoundsViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? CustomRoundsViewCell
        return cell
    }
    
    func setNotesLabelLanguage(){
        let labelTitle = NSLocalizedString("Customize Rounds", comment: "nope")
        notesLabel.text = labelTitle
    }
    
    func setImage(){
        if isLocked == false {
            self.isUserInteractionEnabled = true
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"lock.fill")
            }
        }
//        if isCustom == true {
//            DispatchQueue.main.async {
//                self.lockedOrChecked.image = UIImage.init(systemName:"checkmark.rectangle.fill")
//            }
//        }else {
//            DispatchQueue.main.async {
//                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
//                Session.manager.isCustomSession = false
//            }
//        }
    }
    
    @IBOutlet weak var lockedOrChecked: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var notesLabel: UILabel!
    
    static let xibRID:String = "CustomRoundsViewCell"
}

protocol CustomRoundsDelegate {
    func customRoundsSelected(isCustom: Bool?)
}
