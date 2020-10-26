//
//  PlayerKnownInstrumentNotesHeaderViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class PlayerKnownInstrumentNotesHeaderViewCell: UITableViewCell {
    
    class func createCell(with image: UIImage) -> PlayerKnownInstrumentNotesHeaderViewCell? {
           let nib = UINib(nibName: "PlayerKnownInstrumentNotesHeaderViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? PlayerKnownInstrumentNotesHeaderViewCell
        cell?.commonInit(image)
           return cell
       }
    
    func commonInit(_ image: UIImage) {
        instrumentImage.image = image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: Properties
    @IBOutlet weak var instrumentImage: UIImageView!
    
    @IBOutlet weak var instrumentProficiencyRankingLabel: UILabel!
    
    
}
