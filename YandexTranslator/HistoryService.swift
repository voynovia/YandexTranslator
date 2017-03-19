//
//  HistoryService.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 13.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

protocol HistoryService: DataProvider {

    func getHistory(completionBlock: @escaping TranslatedBlock)
    func getFavourites(completionBlock: @escaping TranslatedBlock)
    
//    func getTranslatedText(completionBlock: @escaping TranslatedBlock)
    func removeTranslatedText(_ text: TranslatedText)
    
    func setHistoryStateTranslatedText(_ text: TranslatedText, state: Bool)
    func setFavoriteStateTranslatedText(_ text: TranslatedText, state: Bool)
}

class HistoryServiceImpl: HistoryService {
    
    let translatedTextDao = TranslatedTextDAO()
    
    func getHistory(completionBlock: @escaping TranslatedBlock) {
        performInRealmQueue { [weak self] in
            if let texts = self?.translatedTextDao.fetchAll(withParams: ["isHistory": true as AnyObject]), texts.count > 0 {
                self?.performInMainQueue { completionBlock(Result.value(texts)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func getFavourites(completionBlock: @escaping TranslatedBlock) {
        performInRealmQueue { [weak self] in
            if let texts = self?.translatedTextDao.fetchAll(withParams: ["isFavourite": true as AnyObject]), texts.count > 0 {
                self?.performInMainQueue { completionBlock(Result.value(texts)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
//    func getTranslatedText(completionBlock: @escaping TranslatedBlock) {
//        performInRealmQueue { [weak self] in
//            if let texts = self?.translatedTextDao.fetchAll(), texts.count > 0 {
//                self?.performInMainQueue { completionBlock(Result.value(texts)) }
//            } else {
//                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
//            }
//        }
//    }
    
    func removeTranslatedText(_ text: TranslatedText) {
        self.translatedTextDao.delete(text)
    }
    
    func setHistoryStateTranslatedText(_ text: TranslatedText, state: Bool) {
        self.translatedTextDao.update(text) { (entry) in
            entry.isHistory = state
        }
    }
    
    func setFavoriteStateTranslatedText(_ text: TranslatedText, state: Bool) {
        self.translatedTextDao.update(text) { (entry) in
            entry.isFavourite = state
        }
    }
    
}
