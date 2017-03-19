//
//  String.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

extension String {
    func substring(from: String, fromEnd: Bool = false) -> String? {
        guard let index = range(of: from, options: fromEnd ? [.backwards, .caseInsensitive] : [.caseInsensitive] )?.upperBound else { return nil }
        return substring(from: index)
    }
    
    func substring(to: String) -> String? { // swiftlint:disable:this variable_name
        guard let index = range(of: to)?.lowerBound else { return nil }
        return substring(to: index)
    }
}
