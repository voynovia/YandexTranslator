//
//  TranslateRequest.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 06.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

enum TranslateRequest: TargetRequest {
    case detect, translate, langs, dictionary
    
    var path: String {
        switch self {
        case .detect: return "https://translate.yandex.net/api/v1.5/tr.json/detect"
        case .translate: return "https://translate.yandex.net/api/v1.5/tr.json/translate"
        case .langs: return "https://translate.yandex.net/api/v1.5/tr.json/getLangs"
        case .dictionary: return "https://dictionary.yandex.net/api/v1/dicservice.json/lookup"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .detect: return ["key": translateYandexKey, "hint": "en,ru"]
        case .translate: return ["key": translateYandexKey]
        case .langs: return ["key": translateYandexKey, "ui": "ru"]
        case .dictionary: return ["key": dictionaryYandexKey, "flags": "4"]
        }
    }
    
}
