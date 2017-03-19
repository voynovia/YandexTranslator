//
//  Definition.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift
import ObjectMapper

struct Definition: Entity, Mappable {
    var language: String?
    var text: String?
    var pos: String? // часть речи
    var gen: String? // пол
    var anm: String? // одушевленная или неодушевленная
    var transcription: String? // транскрипция
    var translation: [Translation]? // Массив переводов
    
    init(language: String?, text: String?, pos: String?, gen: String?, anm: String?, transcription: String?, translations: [Translation]?) {
        self.language = language
        self.text = text
        self.pos = pos
        self.gen = gen
        self.anm = anm
        self.transcription = transcription
        self.translation = translations
    }
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        text <- map["text"]
        pos <- map["pos"]
        gen <- map["gen"]
        anm <- map["anm"]
        transcription <- map["ts"]
        translation <- map["tr"]
    }
}

class DefinitionEntry: Entry {
    var language: String! { didSet { id = compoundKeyValue() } }
    dynamic var text: String! { didSet { id = compoundKeyValue() } }
    dynamic var pos: String! { didSet { id = compoundKeyValue() } }
    dynamic var gen: String!
    dynamic var anm: String!
    dynamic var transcription: String!
    var translation = List<TranslationEntry>()
    
    func compoundKeyValue() -> String {
        if let language = language, let text = text, let pos = pos {
            return "\(language)-\(text)-\(pos)"
        } else if let text = text {
            return text
        }
        return "key"
    }
    
}
