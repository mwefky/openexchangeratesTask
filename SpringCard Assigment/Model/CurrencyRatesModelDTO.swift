//
//  CurrencyRatesModelDTO.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 09/03/2022.
//

import Foundation

public struct CurrencyRatesModelDTO {
    
    let formatedDate: String?
    let currencySymbol: String?
    let currencyRate: Double?
    
    init(formatedDate: String, currencySymbol: String, currencyRate: Double){
        
        self.formatedDate = formatedDate
        self.currencySymbol = currencySymbol
        self.currencyRate = currencyRate
    }
}
