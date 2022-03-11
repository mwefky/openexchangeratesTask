//
//  CurrenciesConverterViewModel.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 11/03/2022.
//

import Foundation
import RxSwift
import RxRelay

struct CurrenciesConverterViewModel {
    
    // MARK: - reactive variable
    var currencyConversionResVar = PublishSubject<Double>()
    var currencyConversionRes: Observable<(Double)> {
        return currencyConversionResVar.asObservable()
    }
    
    var customeErrorVar = PublishSubject<CustomeError>()
    var customeError: Observable<(CustomeError)> {
        return customeErrorVar.asObservable()
    }
    
    var disposeBag = DisposeBag()
    
    func convertCurrency(amount: Double, currency: CurrencyRatesModelDTO?) {
        guard let currency = currency else {
            postError(error: .networkError)
            return
        }
        validateConversion(amount: amount, currency: currency)
    }
    
    private func validateConversion(amount: Double, currency: CurrencyRatesModelDTO) {
        if amount == 0.0 {
            postError(error: .noAmount)
            return
        }
        performConversionWithOutAPI(with: amount, currency: currency)
    }
    
    //MARK: - private func
    private func postError(error: CustomeError) {
        customeErrorVar.onNext(error)
        currencyConversionResVar.disposed(by: disposeBag)
    }
    
    
    //MARK: - If Billing enabled
    private func performConversionWithAPI(amount: Double, currency: CurrencyRatesModelDTO) {
        ApiClient.convertCurrency(amount: amount, toCur: currency.currencySymbol ?? "")
            .observeOn(MainScheduler.instance)
            .subscribe { (conversionValue) in
                guard let conversionValue = conversionValue.response else {
                    return
                }
                currencyConversionResVar.onNext(conversionValue)
            } onError: { (error) in
                postError(error: .networkError)
            }
            .disposed(by: disposeBag)
    }
    
    //MARK: - local basic conversion 
    private func performConversionWithOutAPI(with amount: Double, currency: CurrencyRatesModelDTO) {
        let conversionValue = amount * (currency.currencyRate ?? 0.0)
        currencyConversionResVar.onNext(conversionValue)
    }
}
