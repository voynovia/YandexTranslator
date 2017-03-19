//
//  TranslateTranslateModuleInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

protocol TranslateModuleInput: class, ViperModuleInput {
    func didSelectLanguage(_ lang: Lang)
    func didSetTranslatedText(_ text: TranslatedText)
}
