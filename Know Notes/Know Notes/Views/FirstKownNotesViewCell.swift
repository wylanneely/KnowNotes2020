//
//  FirstKownNotesViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class FirstKownNotesViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    class func createCell() -> FirstKownNotesViewCell? {
           let nib = UINib(nibName: "FirstKownNotesViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? FirstKownNotesViewCell
           return cell
       }
    
}
