//
//  Request.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation
import Alamofire

typealias RequestMethod = Alamofire.HTTPMethod

protocol TargetRequest {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

struct Request: URLRequestConvertible {
    
    var target: TargetRequest
    
    var path: String!
    var method: RequestMethod!
    var headers: [String: String]!
    var parameters: [String: Any]!
    
    init(_ target: TargetRequest) {
        self.target = target
        
        self.path = target.path
        self.method = target.method
        self.headers = target.headers
        self.parameters = target.parameters
    }
    
    func asURLRequest() throws -> URLRequest {
        let request = NSMutableURLRequest(url: Foundation.URL(string: path)!)
        request.httpMethod = method.rawValue
        if let headers = headers { for (key, value) in headers { request.addValue(value, forHTTPHeaderField: key) } }
        return try URLEncoding.queryString.encode(request as URLRequest, with: parameters)
    }
}
