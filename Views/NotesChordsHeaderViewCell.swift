//
//  NotesChordsHeaderViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/12/20.
//

import UIKit

class NotesChordsHeaderViewCell: UITableViewCell{
    
    var delegate: NotesChordsHeaderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setGestureRecognizer()
        }
    
    class func createCell() -> ShuffleNotesViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as? ShuffleNotesViewCell
        return cell
    }
    
    func setUpViews(){
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        borderView.layer.cornerRadius = 10
        
        
    }
    
    

    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ShuffleNotesViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        
        if isLocked {
        } else {
            return
        }
    }
    
    var isLocked: Bool = false
  
    //MARK: Outlets & Actions
    
   
    @IBOutlet weak var borderView: UIView!
 
    
    static let xibRID:String = "NotesChordsHeaderViewCell"
    
}

protocol NotesChordsHeaderDelegate {
    func shuffleModeSelected(mode: ShuffleMode)
}

enum NotesChords: String {
    case off = "Off"
    case manual = "Manual"
    case auto = "Automatically"
    case locked = "Locked"
}
