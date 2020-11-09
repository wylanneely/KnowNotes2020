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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:Properties
    
    func setUPViews(){
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        middleBGView.layer.cornerRadius = 10
        note1Button.layer.cornerRadius = 10
        note2Button.layer.cornerRadius = 10
        note3Button.layer.cornerRadius = 10
        note1Button.layer.borderWidth = 2
        note2Button.layer.borderWidth = 2
        note3Button.layer.borderWidth = 2
        note1Button.layer.borderColor = UIColor.seaFoamBlue.cgColor
        note2Button.layer.borderColor = UIColor.seaFoamBlue.cgColor
        note3Button.layer.borderColor = UIColor.seaFoamBlue.cgColor
    }
    
    class func createCell() -> FirstKnownNotesViewCell? {
        let nib = UINib(nibName: self.xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? FirstKnownNotesViewCell
        return cell
    }
    
    static let xibRID: String = "FirstKnownNotesViewCell"
    
    //MARK: Outlets
    
    @IBOutlet weak var middleBGView: UIView!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    

}
