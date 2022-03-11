//
//  Network.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 27/02/2022.
//

import Foundation
import Alamofire
import RxSwift

enum ApiRouter: URLRequestConvertible {
    
    case getAllCurrenciesRates
    case convertCurrency(amount: Double, toCur: String)
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try NetworkConstants.BASEURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .convertCurrency:
            return .post
        case .getAllCurrenciesRates:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .convertCurrency(let amount, let toCur):
            return "convert/\(amount)/USD/\(toCur)"
        case .getAllCurrenciesRates:
            return "\(NetworkConstants.getAllCurrnciesRates)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .convertCurrency:
            return ["app_id": NetworkConstants.APPID]
        case .getAllCurrenciesRates:
            return ["app_id": NetworkConstants.APPID]
        }
    }
}
