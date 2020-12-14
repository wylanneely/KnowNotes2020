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
    
        var didUnlockGrandPianoHalfs = false
    }
    
    var gameData = GameData()
    
    var products = [SKProduct]()
    
    
    init() {
        _ = gameData.load()
    }
    
    
    func getProduct(containing keyword: String) -> SKProduct? {
        return products.filter { $0.productIdentifier.contains(keyword) }.first
    }
}
