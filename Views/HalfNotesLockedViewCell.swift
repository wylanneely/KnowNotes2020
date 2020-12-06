//
//  HalfNotesLockedViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class HalfNotesLockedViewCell: UITableViewCell {
    
    var isLocked: Bool = true
    var delegate: sharpsFlatsDelegate?
    var isHalfs: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setGestureRecognizer()
        setImage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HalfNotesLockedViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        if isHalfs == false {
            isHalfs = true
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
                self.delegate?.sharpsFlatsSelected(hasHalfs: false)

            }
        } else {
            isHalfs = false
            DispatchQueue.main.async {
                self.lockedOrChecked.image = UIImage.init(systemName:"checkmark.rectangle.fill")
            }
            self.delegate?.sharpsFlatsSelected(hasHalfs: true)
        }
    }
    
    class func createCell() -> HalfNotesLockedViewCell? {
    
        let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? HalfNotesLockedViewCell
        
        return cell
    }
    
    func setUpViews(){
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        borderView.layer.cornerRadius = 10
    }
    
    func setImage(){
        if isLocked == false {
            self.isUserInteractionEnabled = true
                lockedOrChecked.image = UIImage.init(systemName:"rectangle.fill")
        }
        
    }
    
    @IBOutlet weak var lockedOrChecked: UIImageView!
    @IBOutlet weak var borderView: UIView!
    static let xibRID:String = "HalfNotesLockedViewCell"
}

protocol sharpsFlatsDelegate {
    func sharpsFlatsSelected(hasHalfs: Bool)
}

