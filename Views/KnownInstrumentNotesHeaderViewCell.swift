//
//  KnownInstrumentNotesHeaderViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class KnownInstrumentNotesHeaderViewCell: UITableViewCell {

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
    
    @IBOutlet weak var completedKnownNotesLabel: UILabel!
    @IBOutlet weak var totalNotesLabel: UILabel!
    @IBOutlet weak var completedChordsLabel: UILabel!
    @IBOutlet weak var totalChordsLabel: UILabel!
    
}
