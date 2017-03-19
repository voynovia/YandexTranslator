//
//  Transport.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public enum Result<T> {
    case value(T)
    case error(Errors)
}

protocol Transport {
    func requestData(_ request: URLRequest, completionBlock: @escaping (Result<Data>) -> Void)
    func requestJSON(_ request: URLRequest, completionBlock: @escaping (Result<Any>) -> Void)
    func requestObject<T: Mappable>(_ request: URLRequest, type: T.Type, completionBlock: @escaping (Result<T>) -> Void)
    func requestArray<T: Mappable>(_ request: URLRequest, keyPath: String?, type: T.Type, completionBlock: @escaping (Result<[T]>) -> Void)
}

struct TransportImpl: Transport {
    
    let manager: Alamofire.SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        manager = Alamofire.SessionManager(configuration: configuration,
                                           serverTrustPolicyManager: nil)
    }
    
    internal func requestData(_ request: URLRequest, completionBlock: @escaping (Result<Data>) -> Void) {
        manager.request(request).responseData { response in
            switch response.result {
            case .success(let value): completionBlock(Result.value(value))
            case .failure: completionBlock(Result.error(Errors.requsetData))
            }
        }
    }
    
    internal func requestJSON(_ request: URLRequest, completionBlock: @escaping (Result<Any>) -> Void) {
        manager.request(request).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value): completionBlock(Result.value(value))
            case .failure: completionBlock(Result.error(Errors.requestJSON))
            }
        }
    }
    
    internal func requestObject<T: Mappable>(_ request: URLRequest, type: T.Type, completionBlock: @escaping (Result<T>) -> Void) {
        manager.request(request).validate().responseObject { (response: DataResponse<T>) in
            switch response.result {
            case .success(let value): completionBlock(Result.value(value))
            case .failure: completionBlock(Result.error(Errors.requestObject))
            }
        }
    }
    
    internal func requestArray<T: Mappable>(_ request: URLRequest, keyPath: String? = nil, type: T.Type, completionBlock: @escaping (Result<[T]>) -> Void) {
        manager.request(request).responseArray(keyPath: keyPath != nil ? keyPath! : nil) { (response: DataResponse<[T]>) in
            switch response.result {
            case .success(let value): completionBlock(Result.value(value))
            case .failure: completionBlock(Result.error(Errors.requestArray))
            }
        }
    }

}
