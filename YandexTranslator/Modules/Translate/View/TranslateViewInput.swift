//
//  TranslateTranslateViewInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

protocol TranslateViewInput: class {
    
    func setupView(withDictionary dictionary: Dictionary)
    func setupView(withTranslate text: String)

    func setTitleSourceLanguage(_ lang: Lang)
    func setTitleTargetLanguage(_ lang: Lang)
    
    func setupSourceText(_ text: String)
}
