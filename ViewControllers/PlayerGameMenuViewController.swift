//
//  PlayerGameMenuViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/18/20.
//

import GameKit




class PlayerGameMenuViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate, InstrumentCollectionCellDelegate {
    
    
    
    //MARK:IAP
    var IAP = Session.manager.iAPurchases
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isOnline == true {
            //MARK:In APP PUrchase
            IAP.iAPDelegate = self
            GameCenterManager.manager.viewController = self
            localPlayerProfilePhoto.image = GameCenterManager.manager.localPlayerPhoto?.circleMasked
        } else {
            let title = NSLocalizedString("OfflineGameCenterButton", comment: "offline Notes")
            gameCenterButton.setTitle(title, for: .normal)
            gameCenterButton.isEnabled = false
            gameCenterImage.isHidden = true
        }
        setupCollectionView()
        setUpProfilePhotoGestures()
    }
    
    //MARK: Set Up
    func setUpProfilePhotoGestures(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.photoTapped(_:)))
        localPlayerProfilePhoto.isUserInteractionEnabled = true
        localPlayerProfilePhoto.addGestureRecognizer(tapGesture)
    }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 500)
        collectionView?.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        if localizationLanguage == "Chinese"{
            collectionView.backgroundColor = UIColor.chinaYellow
            self.view.backgroundColor = UIColor.chinaYellow
            gameCenterButton.setTitleColor(.black, for: .normal)
            gameCenterButton.setTitleShadowColor(.chinaRed, for: .normal)
        }
    }
    
    //MARK: Unlocked Instruments
    
    var isAcousticGuitarUnlocked: Bool {
        return Session.manager.isAcousticGuitarAvailable
    }
    var isViolinUnlocked: Bool {
        return Session.manager.isViolinAvailable
    }
    var isSaxophoneUnlocked: Bool {
        return Session.manager.isSaxophoneAvailable
    }
    
    //MARK: Properties
    
    var isOnline: Bool {
        return GameCenterManager.manager.isOnline
    }
    
    typealias SuccessHandler = (Bool) -> Void
    
    let OkAlertAction: UIAlertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "ok"), style: .default, handler: nil)
    
    let errorBuy = NSLocalizedString("Error Purchasing", comment: "ok")
    
    func showSingleAlert(withMessage message: String) {
           let alertController = UIAlertController(title: errorBuy, message: message, preferredStyle: .alert)
           alertController.addAction(OkAlertAction)
           self.present(alertController, animated: true, completion: nil)
       }
    
    var unlockAcousticAlertController: UIAlertController {
        
         let product = IAP.getProduct(containing: "IAPAcoustic") ?? nil
        let price = IAPManager.shared.getPriceFormatted(for: product) ?? "0.99"
        
        let alertAcouTitle = NSLocalizedString("Acoustic Locked", comment: "Acoustic Guitar Locked")
        let alertAcouMessage = NSLocalizedString("LockedAcouMessage", comment: "Acoustic Guitar Locked amessage")

        let alert = UIAlertController(title: alertAcouTitle, message: alertAcouMessage, preferredStyle: .alert)
        let action = (UIAlertAction(title: buyTitle + "\(price)", style: .default, handler: { (_) in
            if !IAPManager.shared.canMakePayments() {
                self.showSingleAlert(withMessage: self.IAPNot)
                return
               } else {
                if let product = product{
                IAPManager.shared.buy(product: product) { (result) in
                       DispatchQueue.main.async {
                           switch result {
                           case .success(_):
                            self.IAP.updateGameDataWithPurchasedProduct(product)
                            self.collectionView.reloadData()
                           case .failure(let error): print(error)
                           }
                       }
                }} else {
                    self.showSingleAlert(withMessage:self.errorBuy)
                    return
                }
                   return
               }
        }))
        alert.addAction(action)
        alert.addAction(OkAlertAction)
        return alert
    }
    
    var unlockViolinAlertController: UIAlertController {
             let product = IAP.getProduct(containing: "IAPViolin") ?? nil
            let price = IAPManager.shared.getPriceFormatted(for: product) ?? "0.99"
        
        let violinTitle = NSLocalizedString("Violin Locked", comment: "locked violin")
        let violinMessage = NSLocalizedString("Violin Message", comment: "locked violin message")
        let alert = UIAlertController(title: violinTitle, message: violinMessage, preferredStyle: .alert)
        let action = (UIAlertAction(title: buyTitle + "\(price)", style: .default, handler: { (_) in
            if !IAPManager.shared.canMakePayments() {
                self.showSingleAlert(withMessage: self.IAPNot)
                return
               } else {
                if let product = product{
                IAPManager.shared.buy(product: product) { (result) in
                       DispatchQueue.main.async {
                           switch result {
                           case .success(_):
                            self.IAP.updateGameDataWithPurchasedProduct(product)
                            self.collectionView.reloadData()
                           case .failure(let error): print(error)
                           }
                       }
                }} else {
                    self.showSingleAlert(withMessage:self.errorBuy)
                    return
                }
                   return
               }
        }))
        alert.addAction(action)
        alert.addAction(OkAlertAction)
        return alert
    }
    
    var unlockSaxAlertController: UIAlertController {
        let product = IAP.getProduct(containing: "IAPSax") ?? nil
       let price = IAPManager.shared.getPriceFormatted(for: product) ?? "0.99"
        let saxTitle = NSLocalizedString("Saxophone Locked", comment: "locked saxophone")
        let saxMessage =  NSLocalizedString("Saxophone Message", comment: "locked saxophone message")
        let alert = UIAlertController(title: saxTitle, message: saxMessage, preferredStyle: .alert)
        let action = (UIAlertAction(title: buyTitle + "\(price)", style: .default, handler: { (_) in
            if !IAPManager.shared.canMakePayments() {
                self.showSingleAlert(withMessage: self.IAPNot)
                return
               } else {
                if let product = product{
                IAPManager.shared.buy(product: product) { (result) in
                       DispatchQueue.main.async {
                           switch result {
                           case .success(_):
                            self.IAP.updateGameDataWithPurchasedProduct(product)
                            self.collectionView.reloadData()
                           case .failure(let error): print(error)
                           }
                       }
                }} else {
                    self.showSingleAlert(withMessage:self.errorBuy)
                    return
                }
                   return
               }
        }))
        alert.addAction(action)
        alert.addAction(OkAlertAction)
        return alert
    }
    var finishedGameAlert: UIAlertController {
        
        let exit = NSLocalizedString("Exit", comment: "locked saxophone")
        let exitmessage = NSLocalizedString("Return to main menu", comment: "locked saxophone")
        let leave = NSLocalizedString("Leave", comment: "locked saxophone")
        let cancel = NSLocalizedString("Cancel", comment: "locked saxophone")
        let restore = NSLocalizedString("Restore", comment: "restores purchases")
        let noPurchasesToRestore = NSLocalizedString("noRestore", comment: " no restores purchases")
        
        let alert = UIAlertController(title: exit, message: exitmessage, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: leave, style: .destructive) { (_) in
            self.performSegue(withIdentifier: "toLaunch", sender: self)
        }
        let action2 = UIAlertAction(title: cancel, style: .cancel) { (_) in
        }
        let action3 = UIAlertAction(title: restore, style: .default) { (_) in
            Session.manager.restorePurchases { (result) in
                switch result {
                case .success(let success):
                    if success {
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showSingleAlert(withMessage: noPurchasesToRestore)
                       print(error)
                    }                    
                    return
                }
            }

            
        }
        
        alert.addAction(action)
        alert.addAction(action3)
        alert.addAction(action2)
        
        return alert
    }
    
    //MARK: Outlets & Actions
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var localPlayerProfilePhoto: UIImageView!
    @IBOutlet weak var gameCenterImage: UIImageView!
    @IBOutlet weak var gameCenterButton: UIButton!

    @IBAction func showGameCenterDashboard(_ sender: Any) {
            GameCenterManager.manager.presentGameCenterDashboard()
        }
    
    @objc func photoTapped(_ sender:AnyObject){
            self.present(finishedGameAlert, animated: true, completion: nil)
        }
    
//MARK: Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InstrumentCCell", for: indexPath) as? InstrumentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        switch indexPath.item {
        case 0:
            cell.setUp(type: .grandPiano, isUnlocked: true)
            return cell
        case 1:
            cell.setUp(type: .acousticGuitar, isUnlocked: isAcousticGuitarUnlocked)
            return cell
        case 2:
            cell.setUp(type: .violin, isUnlocked: isViolinUnlocked)
            return cell
        case 3:
            cell.setUp(type: .saxaphone, isUnlocked: isSaxophoneUnlocked )
            return cell
        default:
           return cell
        }
    }
    
    //MARK: Delegate
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func instrumentCellButtonTapped(type: InstrumentType) {
        switch type {
        case .grandPiano:
            performSegue(withIdentifier: "toGrandPianoNotes", sender: self)
        case .acousticGuitar:
            if isAcousticGuitarUnlocked {
                performSegue(withIdentifier: "toAcousticNotes", sender: self)
            } else {
                self.present(unlockAcousticAlertController, animated: true) {
                }
            }
        case .violin:
            if isViolinUnlocked {
                performSegue(withIdentifier: "toViolinNotes", sender: self )
            } else {
                self.present(unlockViolinAlertController, animated: true) {
                }
            }
        case .saxaphone:
            if isSaxophoneUnlocked {
                performSegue(withIdentifier: "toSaxNotes", sender: self )
            } else {
                self.present(unlockSaxAlertController, animated: true) {
                }
            }
        }
    }
    //MARK: Localization
    let localizationLanguage = NSLocalizedString("AppLanguage", comment: "Preffered Language of localization")
    
    let buyTitle = NSLocalizedString("Buy for", comment: "Buy instrument for")

    let IAPNot = NSLocalizedString("In-App Purchases No", comment: "no purchases")
    
    
    
    //MARK: Navigation
   
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
       if identifier == "toAcousticNotes" {
           if isAcousticGuitarUnlocked { return true }
           else { return false } }
       return true
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let vc = segue.destination as? KnownPlayerInstrumentNotesTableViewController {
        switch segue.identifier {
           case "toAcousticNotes" :
               Session.manager.setAcousticSession()
               vc.instrumentImage = UIImage(named: "acoustic_Guitar")
               vc.instrumentType = InstrumentType.acousticGuitar
           case "toGrandPianoNotes" :
               Session.manager.setGrandPianoSession()
               vc.instrumentImage = UIImage(named: "grand_Piano")
               vc.instrumentType = InstrumentType.grandPiano
           case "toViolinNotes" :
            Session.manager.setViolinSession()
            vc.instrumentImage = UIImage(named: "violin")
            vc.instrumentType = InstrumentType.violin
            
        case "toSaxNotes" :
         Session.manager.setSaxophoneSession()
         vc.instrumentImage = UIImage(named: "saxophone")
            vc.instrumentType = InstrumentType.saxaphone
           default:
               return } }
   }
    
}

extension PlayerGameMenuViewController: IAPDelegate{
    func willStartLongProcess() {
    }
    
    func didFinishLongProcess() {
    }
    
    func showIAPRelatedError(_ error: Error) {
    }
    
    func shouldUpdateUI() {
        collectionView.reloadData()
    }
    
    func didFinishRestoringPurchasesWithZeroProducts() {
        
    }
    
    func didFinishRestoringPurchasedProducts() {
        collectionView.reloadData()
    }
}
