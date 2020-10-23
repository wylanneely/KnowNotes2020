//
//  FirstKownNotesViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class FirstKownNotesViewCell: UITableViewCell {

    class func createCell() -> FirstKownNotesViewCell? {
               let nib = UINib(nibName: "FirstKownNotesViewCell", bundle: nil)
            let cell = nib.instantiate(withOwner: self, options: nil).first as? FirstKownNotesViewCell
               return cell
           }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:Properties
    
    func setUPViews(){
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.borderColor = UIColor.coralRed.cgColor
        middleBGView.layer.cornerRadius = 10
    }
    
    @IBOutlet weak var middleBGView: UIView!
    
    
}
