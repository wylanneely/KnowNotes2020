//
//  ShuffleNotesViewCell.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/6/20.
//

import UIKit

class ShuffleNotesViewCell: UITableViewCell{
    
    var delegate: ShuffleModeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
        setOptionControlUp()
        setGestureRecognizer()
        setLanguageLocalization()
        }
    
    
    
    class func createCell() -> ShuffleNotesViewCell? {
        let nib = UINib(nibName: xibRID, bundle: nil)
        if localizationLanguage == "Chinese" {
            let cell = nib.instantiate(withOwner: self, options: nil).last as? ShuffleNotesViewCell
            return cell
        } else {
            let cell = nib.instantiate(withOwner: self, options: nil).first as? ShuffleNotesViewCell
            return cell
        }
    }
    static let localizationLanguage = NSLocalizedString("AppLanguage", comment: "Preffered Language of localization")
    
    let shuffleSetsTitle = NSLocalizedString("Shuffle Sets", comment: "nope")
    let offO = NSLocalizedString("Off", comment: "nope")
    let manualO = NSLocalizedString("Manual", comment: "nope")
    let autoO = NSLocalizedString("Auto", comment: "nope")

    
    func setLanguageLocalization() {
        optionControl.setTitle(offO, forSegmentAt: 0)
        optionControl.setTitle(manualO, forSegmentAt: 1)
        optionControl.setTitle(autoO, forSegmentAt: 2)
        shuffleSetsLabel.text = shuffleSetsTitle
        if ShuffleNotesViewCell.localizationLanguage == "Spanish" {
          let font =  shuffleSetsLabel.font
            let newFont = UIFont(name: font?.familyName ?? "", size: 20)
            shuffleSetsLabel.font = newFont            
        }
    }
    
    @IBOutlet weak var optionsControlsWidth: NSLayoutConstraint!
    func setUpViews(){
        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.seaFoamBlue.cgColor
        borderView.layer.cornerRadius = 10
    }
    
    func setOptionControlUp(){
        // selected option color
        optionControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        // color of other options
        optionControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }

    func setGestureRecognizer(){
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ShuffleNotesViewCell.tapEdit(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    
    @objc func tapEdit(sender: UITapGestureRecognizer) {
        
        if isLocked {
            delegate?.shuffleModeSelected(mode: .locked)
        } else {
            return
        }
    }
    
    var isLocked: Bool = false
    func setLockedState(){
        borderView.layer.backgroundColor = UIColor.beauBlue.cgColor
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        optionControl.layer.backgroundColor = UIColor.lightGray.cgColor
        optionControl.selectedSegmentTintColor = UIColor.darkGray
        optionControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        optionControl.isUserInteractionEnabled = false
        isLocked = true
    }
    //MARK: Outlets & Actions
    
   
    @IBOutlet weak var optionControl: UISegmentedControl!
    @IBOutlet weak var shuffleSetsLabel: UILabel!
    @IBOutlet weak var borderView: UIView!

    
    
    @IBAction func controlChanged(_ sender: Any) {
        switch optionControl.selectedSegmentIndex{
        case 0:
            delegate?.shuffleModeSelected(mode: .off)
        case 1:
            delegate?.shuffleModeSelected(mode: .manual)
        case 2:
            delegate?.shuffleModeSelected(mode: .auto)
        default:
            break
        }
    }
    
    static let xibRID:String = "ShuffleNotesViewCell"
    
}

protocol ShuffleModeDelegate {
    func shuffleModeSelected(mode: ShuffleMode)
}

enum ShuffleMode: String {
    case off = "Off"
    case manual = "Manual"
    case auto = "Automatically"
    case locked = "Locked"
}
