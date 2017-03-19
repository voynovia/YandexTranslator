//
//  Dictionary.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift

struct Dictionary: Entity {
    let text: String // искомое слово
    let direction: String // направление перевода
    let definitions: [Definition] // Массив словарных статей
}

class DictionaryEntry: Entry {
    dynamic var text = "" { didSet { id = compoundKeyValue() } }
    dynamic var direction = "" { didSet { id = compoundKeyValue() } }
    var definitions = List<DefinitionEntry>()
    
    func compoundKeyValue() -> String {
        return "\(text)/\(direction)"
    }
}
