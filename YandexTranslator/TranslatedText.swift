//
//  History.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 13.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift

struct TranslatedText: Entity {
    var text: String
    var direction: String
    var source: Lang
    var target: Lang
    var translate: String
    var date: Date
    var isHistory: Bool = true
    var isFavourite: Bool = false
}

class TranslatedTextEntry: Entry {
    dynamic var text = "" { didSet { id = compoundKeyValue() } } // искомое слово
    dynamic var direction = "" { didSet { id = compoundKeyValue() } } // направление перевода
    dynamic var source: LangEntry!
    dynamic var target: LangEntry!
    dynamic var translate = "" // перевод
    dynamic var date: Date!
    dynamic var isHistory: Bool = true
    dynamic var isFavourite: Bool = false

    func compoundKeyValue() -> String {
        return "\(text)/\(direction)"
    }
}
