//
//  SecondRoundKnownNotesTableViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class SecondRoundKnownNotesViewCell: UITableViewCell {

    class func createCell() -> SecondRoundKnownNotesViewCell? {
           let nib = UINib(nibName: "SecondRoundKnownNotesViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? SecondRoundKnownNotesViewCell
           return cell
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUnlockedViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    func setSecondNoteTo(note: String){
        DispatchQueue.main.async {
            self.secondSelectedNoteButton.setTitle(note, for: .normal)
        }
    }
    
    func setUnlockedViews(){
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        middleBGView.layer.cornerRadius = 10
        firstNoteView.layer.cornerRadius = 10
        secondSelectedNoteButton.layer.cornerRadius = 10
        
        firstNoteView.layer.borderWidth = 2
        secondSelectedNoteButton.layer.borderWidth = 2
        
        firstNoteView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        secondSelectedNoteButton.layer.borderColor = UIColor.seaFoamBlue.cgColor
    }
    
    func setLockedNotesViews(){
        middleBGView.layer.borderWidth = 2
        middleBGView.layer.borderColor = UIColor.lightGray.cgColor
        middleBGView.layer.cornerRadius = 10
        firstNoteView.layer.cornerRadius = 10
        secondSelectedNoteButton.layer.cornerRadius = 10
        firstNoteView.layer.borderWidth = 2
        secondSelectedNoteButton.layer.borderWidth = 2
        firstNoteView.layer.backgroundColor = UIColor.lightGray.cgColor
        secondSelectedNoteButton.layer.backgroundColor = UIColor.lightGray.cgColor
        
        firstNoteView.layer.borderColor = UIColor.black.cgColor
        secondSelectedNoteButton.layer.borderColor = UIColor.black.cgColor
        secondSelectedNoteButton.setTitleColor(UIColor.white, for: .normal)
        firstSelectedNoteLabel.textColor = UIColor.white
    }
    
    @IBOutlet weak var firstNoteView: UIView!
    @IBOutlet weak var middleBGView: UIView!
    @IBOutlet weak var firstSelectedNoteLabel: UILabel!
    @IBOutlet weak var secondSelectedNoteButton: UIButton!
}
