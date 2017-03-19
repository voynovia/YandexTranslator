//
//  Detect.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import ObjectMapper

struct DetectResponse: Mappable {
    var code: Int!
    var lang: String!
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        code <- map["code"]
        lang <- map["lang"]
    }
}
