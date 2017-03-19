//
//  LanguageLanguageViewInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

protocol LanguageViewInput: class {

    func setupInitialState()
    
    func setHeader(_ text: String)
    
    func setupView(withLangs langs: [Lang])
}
