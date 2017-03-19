//
//  Example.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift
import ObjectMapper

struct Example: Entity, Mappable {
    var text: String!
    var translation: [Translation]?
    
    init(text: String!, translation: [Translation]?) {
        self.text = text
        self.translation = translation
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        translation <- map["tr"]
        text <- map["text"]
    }
}

class ExampleEntry: Entry {
    dynamic var text: String = "" { didSet { id = text } }
    var translation = List<TranslationEntry>()
}
