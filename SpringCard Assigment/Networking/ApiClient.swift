//
//  APIManager.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 27/02/2022.
//

import Foundation
import RxSwift
import Alamofire

class ApiClient {
    
    static let shared = ApiClient()
    
    static func getAllCurrenciesRates() -> Observable<CurrencyRatesModel> {
        return request(ApiRouter.getAllCurrenciesRates)
    }
    
    static func convertCurrency(amount: Double, toCur: String) -> Observable<CurrencyConversionModel> {
        return request(ApiRouter.convertCurrency(amount: amount, toCur: toCur))
    }
    
    // MARK: - The request function to get results in an Observable
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable {  (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
