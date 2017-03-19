//
//  HistoryHistoryViewInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

protocol HistoryViewInput: class {
    func setupView(withTexts texts: [TranslatedText])
    func setupInitialState()
}
