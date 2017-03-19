//
//  Direction.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct Direction: Entity {
    let value: String
}

class DirectionEntry: Entry {
    dynamic var value: String = "" { didSet { id = value } }
}
