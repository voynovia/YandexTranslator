//
//  Errors.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 06.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

public enum Errors: Error {
    case valueNotFound, noFetchedData, notImplemented
    case requsetData, requestJSON, requestObject, requestArray
    
    var localizedDescription: String {
        switch self {
        case .valueNotFound:
            return "Value not found in database"
        case .noFetchedData:
            return "no fetched data"
        case .notImplemented:
            return "Function is not implemented"
        default: return "request error"
        }
    }
}
