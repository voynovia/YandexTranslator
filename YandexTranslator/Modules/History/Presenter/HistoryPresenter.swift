//
//  HistoryHistoryPresenter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

class HistoryPresenter: HistoryModuleInput, HistoryViewOutput, HistoryInteractorOutput {
    weak var view: HistoryViewInput!
    var interactor: HistoryInteractorInput!
    var router: HistoryRouterInput!

    func viewIsReady() {

    }
    
    // HistoryViewOutput
    internal func getTranslatedTexts(segmentIndex: Int) {
        if segmentIndex == 0 {
            interactor.getHistory()
        } else {
            interactor.getFavourites()
        }
    }
    internal func removeTranslatedText(_ text: TranslatedText, _ segmentIndex: Int) {
        if segmentIndex == 0 {
            if !text.isFavourite {
                interactor.removeTranslatedText(text)
            } else {
                interactor.setHistoryStateTranslatedText(text, state: false)
            }
        } else {
            if !text.isHistory {
                interactor.removeTranslatedText(text)
            } else {
                interactor.setFavoriteStateTranslatedText(text, state: false)
            }
        }
    }
    internal func changeFavouriteStateTranslatedText(_ text: TranslatedText) {
        if text.isFavourite {
            interactor.setFavoriteStateTranslatedText(text, state: false)
        } else {
            interactor.setFavoriteStateTranslatedText(text, state: true)
        }
    }
    internal func removeAll(_ texts: [TranslatedText], _ segmentIndex: Int) {
        for text in texts {
            removeTranslatedText(text, segmentIndex)
        }
    }
    internal func openTranslatedText(_ text: TranslatedText) {
        router.openTranslatedText(text: text)
    }
    
    // HistoryInteractorOutput
    internal func didGetTranslatedText(_ texts: [TranslatedText]) {
        view.setupView(withTexts: texts)
    }

}
