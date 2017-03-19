//
//  TranslateTranslateViewOutput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation
protocol TranslateViewOutput {
    func viewIsReady()
    func didEditSourceText(text: String)
    func toSelectLanguage(selectableLanguages: SelectableLanguages)
    func changeDirection()
}
