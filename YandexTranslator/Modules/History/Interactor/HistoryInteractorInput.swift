//
//  HistoryHistoryInteractorInput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

protocol HistoryInteractorInput {
    func getHistory()
    func getFavourites()
    
    func removeTranslatedText(_ text: TranslatedText)
    
    func setHistoryStateTranslatedText(_ text: TranslatedText, state: Bool)
    func setFavoriteStateTranslatedText(_ text: TranslatedText, state: Bool)
 }
