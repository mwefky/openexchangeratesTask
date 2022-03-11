//
//  SpringCard_AssigmentTests.swift
//  SpringCard AssigmentTests
//
//  Created by Mina Wefky on 27/02/2022.
//

import XCTest
import RxSwift
import RxRelay

@testable import SpringCard_Assigment

class SpringCard_AssigmentTests: XCTestCase {
    
    let mockCurrenciesResposne = CurrencyRatesModel(timestamp: 1647007200.0,
                                          base: "USD",
                                          rates: ["AED": 3.673007,
                                                  "AFN": 88.353414,
                                                  "ALL": 111.896791,
                                                  "AMD": 515.089983,
                                                  "ANG": 1.799266,
                                                  "AOA": 472.9825,
                                                  "ARS": 108.896911,
                                                  "AUD": 1.365045,
                                                  "AWG": 1.80025,
                                                  "AZN": 1.7,
                                                  "BAM": 1.773079,
                                                  "BBD": 2,
                                                  "BDT": 85.906341,
                                                  "BGN": 1.7799,
                                                  "BHD": 0.376988,
                                                  "BIF": 2046.562941,
                                                  "BMD": 1,
                                                  "BND": 1.357303,
                                                  "BOB": 6.872666,
                                                  "BRL": 5.0195,
                                                  "BSD": 1,
                                                  "BTC": 0.000025438375
                                                 ])
    
    var mockCurrencyDTO = CurrencyRatesModelDTO(formatedDate: "", currencySymbol: "BSD", currencyRate: 1.0)
    
    var getCurrenciesViewModel = CurrenciesListViewModel()
    var convertToUSDViewModel = CurrenciesConverterViewModel()
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_Currencies_Conversion_To_DTO() {
        getCurrenciesViewModel.convertCurrencyListToDTO(currenciesList: mockCurrenciesResposne)
        getCurrenciesViewModel.currencyList.subscribe { currencies in
            if currencies.element?.isEmpty ?? false {
                XCTFail()
            }
        }.disposed(by: disposeBag)
    }
    
    func test_currencies_Conversion_to_USD() {
        convertToUSDViewModel.convertCurrency(amount: 50, currency: mockCurrencyDTO)
        convertToUSDViewModel.currencyConversionRes.subscribe { conversionValue in
            if (conversionValue.element ?? 0) != 50 {
                XCTFail()
            }
        }
    }
    
    func test_currencies_Conversion_Fails() {
        convertToUSDViewModel.convertCurrency(amount: 0, currency: mockCurrencyDTO)
        convertToUSDViewModel.currencyConversionRes.subscribe { conversionValue in
            if conversionValue.element != nil {
                XCTFail()
            }
        }
    }
    
    
}
