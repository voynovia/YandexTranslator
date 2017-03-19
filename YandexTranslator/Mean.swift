//
//  Mean.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift
import ObjectMapper

struct Mean: Entity, Mappable {
    var text: String!
    
    init(text: String!) {
        self.text = text
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        text <- map["text"]
    }
}

class MeanEntry: Entry {
    dynamic var text: String = "" { didSet { id = text } }
}
