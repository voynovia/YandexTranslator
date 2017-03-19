//
//  Translation.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import ObjectMapper

struct TranslateResponse: Mappable {
    var lang: String! //  определенная пара языков
    var text: [String]! // перевод
    
    init(lang: String, text: [String]) {
        self.lang = lang
        self.text = text
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        lang <- map["lang"]
        text <- map["text"]
    }
}
