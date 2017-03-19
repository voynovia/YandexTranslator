//
//  HistoryHistoryViewOutput.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

protocol HistoryViewOutput {
    func viewIsReady()
    
    func getTranslatedTexts(segmentIndex: Int)

    func removeAll(_ texts: [TranslatedText], _ segmentIndex: Int)
    
    func removeTranslatedText(_ text: TranslatedText, _ segmentIndex: Int)
    func changeFavouriteStateTranslatedText(_ text: TranslatedText)
    
    func openTranslatedText(_ text: TranslatedText)
}
