//
//  LanguageLanguageInteractorInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

protocol LanguageInteractorInput {
    func getSourceLangs()
    func getTargetLangs(_ pair: Lang)
}
