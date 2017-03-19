//
//  TranslateTranslateInteractorInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

protocol TranslateInteractorInput {
    func detect(text: String)
    func getLangs()
    func translate(text: String, direction: String)
    func translate(word: String, direction: String)
    func getPair(_ lang: Lang)
    func getLang(_ selectableLanguage: SelectableLanguages, _ abbr: String)
}
