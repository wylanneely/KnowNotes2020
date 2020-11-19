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
    
    
    
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var instrumentImage: UIImageView!
    @IBOutlet weak var instrumentButton: UIButton!
    
    
    @IBAction func instrumentButtonTapped(_ sender: Any) {
        
        
    }
    
    
    
    
    func setUp(type: InstrumentType, isLocked: Bool){
        self.isLocked = isLocked
        
        switch type {
        case .grandPiano:
            self.instrumentType = type
            setLockedState()
        case .acousticGuitar:
            self.instrumentType = type
            setLockedState()

        case .violin:
            self.instrumentType = type
            setLockedState()

      
        }
        
        
    }
    
    func setLockedState(){
        instrumentButton.layer.cornerRadius = 10
        backgroundColorView.layer.cornerRadius = 10
        backgroundColorView.layer.masksToBounds = true
        
        if isLocked {
            instrumentButton.isUserInteractionEnabled = false
            self.backgroundColorView.layer.backgroundColor = UIColor.lightGray.cgColor
            instrumentButton.setTitleColor(UIColor.white, for: .normal)
            instrumentButton.layer.borderColor = UIColor.darkGray.cgColor
        } else {
            instrumentButton.isUserInteractionEnabled = true
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
