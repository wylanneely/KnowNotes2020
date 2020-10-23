//
//  BeginEditNotesLessonViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class BeginEditNotesLessonViewCell: UITableViewCell {
    
    class func createCell() -> BeginEditNotesLessonViewCell? {
           let nib = UINib(nibName: "BeginEditNotesLessonViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? BeginEditNotesLessonViewCell
           return cell
       }

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var delegate: BeginLessonDelegate?
    
    func setUpViews(){
        beginButton.layer.cornerRadius = 10
    }
    
    @IBOutlet weak var beginButton: UIButton!
    @IBAction func beginButtonTapped(_ sender: Any) {
        DispatchQueue.main.async {
            self.delegate?.beginLesssonButtonTapped()
        }
    }
    
    
}


protocol BeginLessonDelegate {
    func beginLesssonButtonTapped()
}
