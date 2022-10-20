//
//  IPAManager.swift
//  consumable_App_Purchase
//
//  Created by AVINASH on 19/10/22.
//

import Foundation
import StoreKit

final class IPAManager : NSObject , SKProductsRequestDelegate , SKPaymentTransactionObserver {
    static let shared = IPAManager()

    var products = [SKProduct]()
    
    private var completion :((Int) -> Void)?
    
    enum Product : String , CaseIterable {
        case dimond_500
        case dimond_1000
        case dimond_2000
        case dimond_5000
        
        var count: Int {
            switch self {
            case .dimond_500:
                return 500
            case .dimond_1000:
                return 1000
            case .dimond_2000:
                return 2000
            case .dimond_5000:
                return 5000
            }
        }
    }
    
    public func featchProduct () {
        let request = SKProductsRequest(productIdentifiers: Set(Product.allCases.compactMap({ $0.rawValue })))
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("response.products.count\(response.products.count)")
        self.products = response.products
    }
    
    public func purchase(product :Product , completion : @escaping ((Int) -> Void)) {
        guard SKPaymentQueue.canMakePayments() else {
            return 
        }
        guard let storekitProduct = products.first(where: { $0.productIdentifier == product.rawValue}) else {
            return
        }
        self.completion = completion
        
        
        let paymentRequest = SKPayment(product: storekitProduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(paymentRequest)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach({
            switch $0.transactionState {
                
            case .purchasing:
                break
            case .purchased:
                if let product = Product(rawValue: $0.payment.productIdentifier){
                    completion?(product.count)
                    
                    var valuetrue = true
                   UserDefaults.standard.set(valuetrue, forKey: "num")
                }
                SKPaymentQueue.default().finishTransaction($0)
                SKPaymentQueue.default().remove(self)
               
            case .failed:
                break
            case .restored:
                break
            case .deferred:
                break
            @unknown default:
                break
            }
        }
        )
    }
}
