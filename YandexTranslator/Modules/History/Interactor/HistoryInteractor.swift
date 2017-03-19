//
//  HistoryHistoryInteractor.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

class HistoryInteractor: HistoryInteractorInput {

    weak var output: HistoryInteractorOutput!

    private var historyService = HistoryServiceImpl()
    
    func getHistory() {
        historyService.getHistory { [weak self] result in
            switch result {
            case .value(let value): self?.output.didGetTranslatedText(value)
            case .error: self?.output.didGetTranslatedText([])
            }
        }
    }
    func getFavourites() {
        historyService.getFavourites { [weak self] result in
            switch result {
            case .value(let value): self?.output.didGetTranslatedText(value)
            case .error: self?.output.didGetTranslatedText([])
            }
        }
    }
    
    internal func removeTranslatedText(_ text: TranslatedText) {
        historyService.removeTranslatedText(text)
    }
    
    internal func setHistoryStateTranslatedText(_ text: TranslatedText, state: Bool) {
        historyService.setHistoryStateTranslatedText(text, state: state)
    }

    internal func setFavoriteStateTranslatedText(_ text: TranslatedText, state: Bool) {
        historyService.setFavoriteStateTranslatedText(text, state: state)
    }
}
