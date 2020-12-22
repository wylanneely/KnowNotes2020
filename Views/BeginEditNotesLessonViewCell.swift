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
        setLanguageOfbutton()
    }
    
    func setLanguageOfbutton() {
     let beginTitle = NSLocalizedString("Begin Lesson", comment: "None")
        beginButton.setTitle(beginTitle, for: .normal)
    }
    
    func setUpViews(){
        beginButton.layer.cornerRadius = 10
        beginButton.layer.borderWidth = 2
        beginButton.layer.borderColor = UIColor.beauBlue.cgColor
        if ShuffleNotesViewCell.localizationLanguage == "Spanish" {
            let font =  beginButton.titleLabel?.font
            let newFont = UIFont(name: font?.familyName ?? "", size: 20)!
            beginButton.titleLabel?.font = newFont
        }
    }
    
    
    class func createCell() -> BeginEditNotesLessonViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        if localizationLanguage == "Chinese" {
            let cell = nib.instantiate(withOwner: self, options: nil).last as? BeginEditNotesLessonViewCell
            return cell
        } else {
            let cell = nib.instantiate(withOwner: self, options: nil).first as? BeginEditNotesLessonViewCell
            return cell
        }
    }
    static let localizationLanguage = NSLocalizedString("AppLanguage", comment: "Preffered Language of localization")
    
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
