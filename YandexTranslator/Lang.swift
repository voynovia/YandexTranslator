//
//  Lang.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

class Lang: Entity {
    var abbr: String!
    var name: String!
    
    init(abbr: String, name: String) {
        self.abbr = abbr
        self.name = name
    }
}

class LangEntry: Entry {
    dynamic var abbr: String! { didSet { id = abbr } }
    dynamic var name: String!
}
