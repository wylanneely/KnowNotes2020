//
//  HalfNotesLockedViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class HalfNotesLockedViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    @IBOutlet weak var borderView: UIView!
    static let xibRID:String = "HalfNotesLockedViewCell"
    
}
