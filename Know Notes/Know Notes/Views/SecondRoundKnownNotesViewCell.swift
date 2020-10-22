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
        // Initialization code
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
    
    @IBOutlet weak var firstSelectedNoteLabel: UILabel!
    @IBOutlet weak var secondSelectedNoteButton: UIButton!
}
