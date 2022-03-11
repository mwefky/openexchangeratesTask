//
//  CurrencyRatesModel.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 01/03/2022.
//

import Foundation
import UIKit
// MARK: - CurrencyRatesModel
struct CurrencyRatesModel: Codable {
    var timestamp: Double
    let base: String
    let rates: [String: Double]
    
    init(timestamp: Double, base: String, rates: [String: Double]){
        self.timestamp = timestamp
        self.base = base
        self.rates = rates
    }
}

