//
//  IAPManager.swift
//  Know Notes
//
//  Created by Wylan L Neely on 12/14/20.
//

import StoreKit

class IAPManager: NSObject, SKPaymentTransactionObserver{
    
    //MARK: Properties
    static let shared = IAPManager()
    
    var onReceiveProductsHandler: ((Result<[SKProduct], IAPManagerError>) -> Void)?
    var onBuyProductHandler: ((Result<Bool, Error>) -> Void)?
    
    var totalRestoredPurchases = 0

    
    func canMakePayments() -> Bool {
          return SKPaymentQueue.canMakePayments()
      }
      

    

    private override init() {
        super.init()
    }
    
    
    // MARK: - Purchase Products

    func buy(product: SKProduct, withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(payment)
         
            // Keep the completion handler.
            onBuyProductHandler = handler
        }

    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
            if let error = error as? SKError {
                
                if error.code != .paymentCancelled {
                    print("IAP Restore Error:", error.localizedDescription)
                    onBuyProductHandler?(.failure(error))
                } else {
                    onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
                }
                
            }
        }
    
    //MARK: Restore Purchases
    
   
    
    func restorePurchases(withHandler handler: @escaping ((_ result: Result<Bool, Error>) -> Void)) {
            onBuyProductHandler = handler
          //  totalRestoredPurchases = 0
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        
            
        if totalRestoredPurchases != 0 {
            onBuyProductHandler?(.success(true))
        } else {
            print("IAP: No purchases to restore!")
            onBuyProductHandler?(.success(false))
        }
        
        
    }
    
    
    // MARK: - General Methods
    
    fileprivate func getProductIDs() -> [String]? {
        guard let url = Bundle.main.url(forResource: "IAP_ProductIDs", withExtension: "plist") else { return nil }
        do {
            let data = try Data(contentsOf: url)
            let productIDs = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String] ?? []
            return productIDs
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func startObserving() {
        SKPaymentQueue.default().add(self)
    }
    
    func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    func getPriceFormatted(for product: SKProduct?) -> String? {
        guard let p = product else {return "error"}
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = p.priceLocale
        return formatter.string(from: p.price)
    }
    
        
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchased:
                onBuyProductHandler?(.success(true))
                SKPaymentQueue.default().finishTransaction(transaction)
            case .restored:
                
                print(transaction.transactionIdentifier ?? "no identifier")
                print(transaction.original?.transactionIdentifier ?? "no identifier")
                if let  restoredPayment = transaction.original?.payment {
                    
                    Session.manager.iAPurchases.restoreGameDataWithPayment(restoredPayment)
                    
                }


                
                totalRestoredPurchases += 1
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error as? SKError {
                    if error.code != .paymentCancelled {
                        onBuyProductHandler?(.failure(error))
                    } else {
                        onBuyProductHandler?(.failure(IAPManagerError.paymentWasCancelled))
                    }
                    print("IAP Error:", error.localizedDescription)
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred, .purchasing: break
            @unknown default: break
            }
        }
    }

    func getProducts(withHandler productsReceiveHandler: @escaping (_ result: Result<[SKProduct], IAPManagerError>) -> Void) {
        // Keep the handler (closure) that will be called when requesting for
           // products on the App Store is finished.
           onReceiveProductsHandler = productsReceiveHandler
        
           // Get the product identifiers.
           guard let productIDs = getProductIDs() else {
               productsReceiveHandler(.failure(.noProductIDsFound))
               return
           }
        
           // Initialize a product request.
           let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        
           // Set self as the its delegate.
           request.delegate = self
        
           // Make the request.
           request.start()
    }
    
   
    

    enum IAPManagerError: Error {
        case noProductIDsFound
        case noProductsFound
        case paymentWasCancelled
        case productRequestFailed
    }
}


extension IAPManager: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        if products.count > 0 {
            onReceiveProductsHandler?(.success(products))
        } else {
            onReceiveProductsHandler?(.failure(.noProductsFound))
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        onReceiveProductsHandler?(.failure(.productRequestFailed))
    }
    
    func requestDidFinish(_ request: SKRequest) {
     
    }
 
}



extension IAPManager.IAPManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noProductIDsFound: return "No In-App Purchase product identifiers were found."
        case .noProductsFound: return "No In-App Purchases were found."
        case .productRequestFailed: return "Unable to fetch available In-App Purchase products at the moment."
        case .paymentWasCancelled: return "In-App Purchase process was cancelled."
        }
    }
}
