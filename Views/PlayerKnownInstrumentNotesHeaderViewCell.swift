//
//  PlayerKnownInstrumentNotesHeaderViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class PlayerKnownInstrumentNotesHeaderViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit(image: UIImage, rank: String, completedNotes: Int ) {
           instrumentImage.image = image
           instrumentProficiencyRankingLabel.text = rank
           completedNotesLabel.text = "\(completedNotes) Notes Unlocked"
       }
    
    class func createCell() -> PlayerKnownInstrumentNotesHeaderViewCell? {
           let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? PlayerKnownInstrumentNotesHeaderViewCell
           return cell
       }

    //MARK: Properties
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentProficiencyRankingLabel: UILabel!
    @IBOutlet weak var completedNotesLabel: UILabel!
    
    static let xibRID: String = "PlayerKnownInstrumentNotesHeaderViewCell"
    
}
