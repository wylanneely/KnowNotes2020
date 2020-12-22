//
//  PlayerKnownInstrumentNotesHeaderViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class PlayerKnownInstrumentNotesHeaderViewCell: UITableViewCell {
    static let xibRID: String = "PlayerKnownInstrumentNotesHeaderViewCell"

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit(image: UIImage, rank: String, completedNotes: Int ) {
        instrumentImage.image = image
        instrumentProficiencyRankingLabel.text = rank
        completedNotesLabel.text = "\(completedNotes)" + nUnlockedTitle
        notesChordsLabel.text = headerTitle
    }
    
    class func createCell() -> PlayerKnownInstrumentNotesHeaderViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        if localizationLanguage == "Chinese" {
            let cell = nib.instantiate(withOwner: self, options: nil).last as? PlayerKnownInstrumentNotesHeaderViewCell
            return cell
        } else {
            let cell = nib.instantiate(withOwner: self, options: nil).first as? PlayerKnownInstrumentNotesHeaderViewCell
            return cell
        }
    }
    static let localizationLanguage = NSLocalizedString("AppLanguage", comment: "Preffered Language of localization")


    //MARK: Properties
    func setProgressBar(score: Int){
        let progress = Float(score/30)
        progressBarr.setProgress(progress, animated: true)
    }
    
    //MARK:Language Localization Views
    
    let nUnlockedTitle = NSLocalizedString("Notes Unlocked", comment: "no comment")
    let headerTitle = NSLocalizedString("Regular Gameplay", comment: "no comment")

    
    
    
    @IBOutlet weak var progressBarr: UIProgressView!
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentProficiencyRankingLabel: UILabel!
    @IBOutlet weak var completedNotesLabel: UILabel!
    @IBOutlet weak var notesChordsLabel: UILabel!
        
    
    
}
