//
//  InstrumentCollectionViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/18/20.
//

import UIKit


class InstrumentCollectionViewCell: UICollectionViewCell {
    
    var instrumentType: InstrumentType = .grandPiano
    
    var isLocked: Bool = true
    
     var delegate: InstrumentCollectionCellDelegate?
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentButton: UIButton!
    @IBOutlet weak var instrumentLabel: UILabel!
    
    @IBAction func instrumentButtonTapped(_ sender: Any) {
        delegate?.instrumentCellButtonTapped(type: self.instrumentType)
    }
    
    func setUp(type: InstrumentType, isUnlocked: Bool){
        
        self.isLocked = !isUnlocked
        instrumentButton.setTitle("  Play  ", for: .normal)

        switch type {
        case .grandPiano:
            self.instrumentType = type
            setLockedState()
        case .acousticGuitar:
            self.instrumentType = type
            instrumentLabel.text = "Acoustic Guitar"
            instrumentImage.image = UIImage.ImageWithName(name: "acoustic_Guitar")
            instrumentLabel.textColor = UIColor.middlePurple

            setLockedState()
        case .violin:
            self.instrumentType = type
            setLockedState()
            instrumentLabel.text = "Violin"
            instrumentImage.image = UIImage.ImageWithName(name: "violin")
        }
        
    }
    
    func setLockedState(){
        instrumentButton.layer.cornerRadius = 10
        backgroundColorView.layer.cornerRadius = 10
        backgroundColorView.layer.masksToBounds = true
        
        if isLocked {
            instrumentLabel.textColor = UIColor.darkGray
            instrumentButton.setTitle("locked", for: .normal)
            self.backgroundColorView.layer.backgroundColor = UIColor.lightGray.cgColor
            instrumentButton.setTitleColor(UIColor.white, for: .normal)
            instrumentButton.layer.borderColor = UIColor.darkGray.cgColor
        } else {
            self.backgroundColorView.layer.backgroundColor = self.returnInstrumentColor().cgColor
            instrumentButton.setTitleColor(UIColor.mediumTurqouise, for: .normal)
            instrumentButton.layer.borderColor = UIColor.mediumTurqouise.cgColor
        }
        
    }
    
    private func returnInstrumentColor()-> UIColor {
        switch self.instrumentType {
        case .acousticGuitar:
            return UIColor.coralRed
        case .grandPiano:
            return UIColor.gameplayBlue
        case .violin:
            return UIColor.peach
        }}
    
}

protocol InstrumentCollectionCellDelegate {
    func instrumentCellButtonTapped(type: InstrumentType)
}
