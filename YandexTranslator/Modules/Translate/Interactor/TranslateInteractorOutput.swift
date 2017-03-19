//
//  TranslateTranslateInteractorOutput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

protocol TranslateInteractorOutput: class {
    func didGetDictionary(_ dictionary: Dictionary)
    func didGetTranslate(_ text: String)
    func didGetPairs(_ langs: [Lang])
    
    func didGetLang(_ selectableLanguage: SelectableLanguages, _ lang: Lang)
}
