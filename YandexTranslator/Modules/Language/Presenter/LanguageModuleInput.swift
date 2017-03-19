//
//  LanguageLanguageModuleInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

protocol LanguageModuleInput: class, ViperModuleInput {
    func setup(_ selectableLanguages: SelectableLanguages, pair: Lang?)
}
