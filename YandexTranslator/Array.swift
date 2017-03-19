//
//  Array.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func unique() -> [Element] {
        var seen = [Element]()
        for element in self {
            if !seen.contains(element) { seen.append(element) }
        }
        return seen
    }
}
