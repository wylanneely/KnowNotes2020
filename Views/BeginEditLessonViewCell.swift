//
//  BeginEditLessonViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class BeginEditLessonViewCell: UITableViewCell {
    
    class func createCell() -> BeginEditLessonViewCell? {
           let nib = UINib(nibName: "BeginEditLessonViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? BeginEditLessonViewCell
           return cell
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
