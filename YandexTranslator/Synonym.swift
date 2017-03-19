//
//  Synonym.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift
import ObjectMapper

struct Synonym: Entity, Mappable {
    var text: String?
    var pos: String?
    var gen: String?
    var compoundKey: String!

    init(text: String?, pos: String?, gen: String?) {
        self.text = text
        self.pos = pos
        self.gen = gen
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        text <- map["text"]
        pos <- map["pos"]
        gen <- map["gen"]
    }
}

class SynonymEntry: Entry {
    dynamic var text: String! { didSet { id = compoundKeyValue() } }
    dynamic var pos: String! { didSet { id = compoundKeyValue() } }
    dynamic var gen: String!
    
    func compoundKeyValue() -> String {
        if let text = text, let pos = pos {
            return "\(text)-\(pos)"
        } else if let text = text {
            return text
        }
        return "key"
    }
}
