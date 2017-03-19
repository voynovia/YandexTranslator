//
//  Translation.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift
import ObjectMapper

struct Translation: Entity, Mappable {
    var text: String?
    var pos: String?
    var gen: String?
    var asp: String?
    var synonym: [Synonym]? // Массив синонимов
    var mean: [Mean]? // Массив значений
    var example: [Example]? // Массив примеров
    
    init(text: String?, pos: String?, gen: String?, asp: String?, synonyms: [Synonym]?, means: [Mean]?, examples: [Example]?) {
        self.text = text
        self.pos = pos
        self.gen = gen
        self.asp = asp
        self.synonym = synonyms
        self.mean = means
        self.example = examples
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        text <- map["text"]
        pos <- map["pos"]
        gen <- map["gen"]
        asp <- map["asp"]
        synonym <- map["syn"]
        mean <- map["mean"]
        example <- map["ex"]
    }
}

class TranslationEntry: Entry {
    dynamic var text: String! { didSet { id = compoundKeyValue() } }
    dynamic var pos: String! { didSet { id = compoundKeyValue() } }
    dynamic var gen: String!
    dynamic var asp: String!
    var synonym = List<SynonymEntry>()
    var mean = List<MeanEntry>()
    var example = List<ExampleEntry>()
    
    func compoundKeyValue() -> String {
        if let text = text, let pos = pos {
            return "\(text)-\(pos)"
        } else if let text = text {
            return text
        }
        return "key"
    }
}
