//
//  BeginEditNotesLessonViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class BeginEditNotesLessonViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        beginButton.pulsate()
    }
    
    func setUpViews(){
        beginButton.layer.cornerRadius = 10
        beginButton.layer.borderWidth = 2
        beginButton.layer.borderColor = UIColor.beauBlue.cgColor
    }
    
    class func createCell() -> BeginEditNotesLessonViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? BeginEditNotesLessonViewCell
        return cell
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Properties
    
    var delegate: BeginLessonDelegate?
    static let xibRID: String = "BeginEditNotesLessonViewCell"
    
    //MARK: Outlets, Actions

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
