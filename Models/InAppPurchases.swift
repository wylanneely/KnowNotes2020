//
//  IAPurchases.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/14/20.
//

import Foundation
import StoreKit

class InAppPurchases {
    
    struct GameData: Codable, SettingsManageable {
        
        
        var didUnlockGrandPianoHalfNotes: Bool = false

        var didUnlockTheAcousticGuitar: Bool = false
        
        var didUnlockAcouGuitarMinorChords: Bool = false
        
        var didUnlockViolin: Bool = false
        
        var didUnlockSaxophone: Bool = false
   
    }
    
    var gameData = GameData()
    
    var products = [SKProduct]()
    
    var iAPDelegate: IAPDelegate?
    
    
    init() {
        _ = gameData.load()
    }
    
    
    func getProduct(containing keyword: String) -> SKProduct? {
        return products.filter { $0.productIdentifier.contains(keyword) }.first
    }
    
    func updateGameDataWithPurchasedProduct(_ product: SKProduct) {
            // Update the proper game data depending on the keyword the
            // product identifier of the give product contains.
       
            //Unlock Acoustic Guitar
        if product.productIdentifier.contains("IAPAcoustic") {
            gameData.didUnlockTheAcousticGuitar = true
            Session.leaderboard.unlockAcousticGuitarLocally()
        }
        //Unlock Acoustic Guitar Minor Chords
        if product.productIdentifier.contains("agmc") {
            gameData.didUnlockAcouGuitarMinorChords = true
            Session.leaderboard.unlockAcousticGuitarMinorChordsLocally()
        }
        //unlock Grand Piano Half Notes
        if product.productIdentifier.contains("gphn") {
            gameData.didUnlockGrandPianoHalfNotes = true
            Session.leaderboard.unlockGrandPiranoHalfsLocally()
        }
        //Unlock Violin
        if product.productIdentifier.contains("IAPViolin") {
            gameData.didUnlockViolin = true
            Session.leaderboard.unlockViolinLocally()
        }
        //Unlock Sax
        if product.productIdentifier.contains("IAPSax") {
            gameData.didUnlockSaxophone = true
            Session.leaderboard.unlockSaxLocally()

        }
        _ =  gameData.update()
        iAPDelegate?.shouldUpdateUI()
    }
    
    func restoreGameDataWithPayment(_ product: SKPayment) {
            // Update the proper game data depending on the keyword the
            // product identifier of the give product contains.
       
            //Unlock Acoustic Guitar
        if product.productIdentifier.contains("IAPAcoustic") {
            gameData.didUnlockTheAcousticGuitar = true
            Session.leaderboard.unlockAcousticGuitarLocally()
        }
        //Unlock Acoustic Guitar Minor Chords
        if product.productIdentifier.contains("agmc") {
            gameData.didUnlockAcouGuitarMinorChords = true
            Session.leaderboard.unlockAcousticGuitarMinorChordsLocally()
        }
        //unlock Grand Piano Half Notes
        if product.productIdentifier.contains("gphn") {
            gameData.didUnlockGrandPianoHalfNotes = true
            Session.leaderboard.unlockGrandPiranoHalfsLocally()
        }
        //Unlock Violin
        if product.productIdentifier.contains("IAPViolin") {
            gameData.didUnlockViolin = true
            Session.leaderboard.unlockViolinLocally()
        }
        //Unlock Sax
        if product.productIdentifier.contains("IAPSax") {
            gameData.didUnlockSaxophone = true
            Session.leaderboard.unlockSaxLocally()

        }
        _ =  gameData.update()
        iAPDelegate?.shouldUpdateUI()
    }
}

protocol IAPDelegate {
    func willStartLongProcess()
    func didFinishLongProcess()
    func showIAPRelatedError(_ error: Error)
    func shouldUpdateUI()
    func didFinishRestoringPurchasesWithZeroProducts()
    func didFinishRestoringPurchasedProducts()
}

