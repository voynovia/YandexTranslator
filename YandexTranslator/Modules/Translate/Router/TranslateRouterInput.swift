//
//  TranslateTranslateRouterInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

protocol TranslateRouterInput {
    func openLanguageSelection(_ selectableLanguages: SelectableLanguages, pair: Lang?)
}
