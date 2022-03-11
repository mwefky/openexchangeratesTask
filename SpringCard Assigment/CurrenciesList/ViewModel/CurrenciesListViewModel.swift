//
//  CurrenciesListViewModel.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 01/03/2022.
//

import Foundation
import RxSwift
import RxRelay

struct CurrenciesListViewModel {
    
    // MARK: - reactive variable
    
    var currencyListVar = PublishSubject<[CurrencyRatesModelDTO]>()
    var currencyList: Observable<([CurrencyRatesModelDTO])> {
        return currencyListVar.asObservable()
    }
    
    var customeErrorVar = PublishSubject<CustomeError>()
    var customeError: Observable<(CustomeError)> {
        return customeErrorVar.asObservable()
    }
    
    var disposeBag = DisposeBag()
    
    func fetchCurrenciesList() {
        
        ApiClient.getAllCurrenciesRates()
            .observeOn(MainScheduler.instance)
            .subscribe { (currencyRes) in
                convertCurrencyListToDTO(currenciesList: currencyRes)
            } onError: { (error) in
                publishError(error: .networkError)
            }
            .disposed(by: disposeBag)
    }
    
    func convertCurrencyListToDTO(currenciesList :CurrencyRatesModel) {
        var currencyRates: [CurrencyRatesModelDTO] = [CurrencyRatesModelDTO]()
        let formatedDate = currenciesList.timestamp.dateFormatted(withFormat: "MM/dd/yyyy")
        var currencyDTO: CurrencyRatesModelDTO?
        for currency in currenciesList.rates {
            currencyDTO = CurrencyRatesModelDTO(formatedDate: formatedDate, currencySymbol: currency.key, currencyRate: currency.value)
            currencyRates.append(currencyDTO!)
        }
        currencyListVar.onNext(currencyRates)
    }
    
    // MARK: - private funcs
    private func publishError(error: CustomeError) {
        customeErrorVar.onNext(error)
        currencyListVar.disposed(by: disposeBag)
    }
}
