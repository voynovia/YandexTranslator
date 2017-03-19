//
//  TranslateOfflineDataProvider.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

protocol OfflineDataProvider: DataProvider {
    func translate(_ text: String, direction: String, _ completionBlock: @escaping TranslateBlock)
    func dictionary(_ text: String, direction: String, _ completionBlock: @escaping DictionaryBlock)
    func getLangs(_ completionBlock: @escaping LangsBlock)
    func getDirections(_ completionBlock: @escaping DirectionsBlock)
    func getPairs(_ lang: Lang, _ completionBlock: @escaping LangsBlock)
    func getSourceLangs(_ completionBlock: @escaping LangsBlock)
    func getTargetLangs(_ pair: Lang, _ completionBlock: @escaping LangsBlock)
    func getLang(_ abbr: String, _ completionBlock: @escaping LangBlock)
    
    func getTranslatedText(_ completionBlock: @escaping TranslatedBlock)
    func removeTranslatedText(_ text: TranslatedText)
}

class TranslateOfflineDataProvider: OfflineDataProvider {
    
    let translatedTextDao = TranslatedTextDAO()
    func translate(_ text: String, direction: String, _ completionBlock: @escaping TranslateBlock) {
        performInRealmQueue { [weak self] in
            let predicate = NSPredicate(format: "text = %@ AND direction = %@", text, direction)
            if let translate = self?.translatedTextDao.fetchAllWithPredicate(predicate).first {
                let result = TranslateResponse(lang: translate.direction, text: [translate.translate])
                self?.performInMainQueue { completionBlock(Result.value(result)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.valueNotFound)) }
            }
        }
    }
    
    let dictionaryDAO = DictionaryDAO()
    func dictionary(_ text: String, direction: String, _ completionBlock: @escaping DictionaryBlock) {
        performInRealmQueue { [weak self] in
            let predicate = NSPredicate(format: "text = %@ AND direction = %@", text, direction)
            if let dictionary = self?.dictionaryDAO.fetchAllWithPredicate(predicate).first {
                self?.performInMainQueue { completionBlock(Result.value(dictionary)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.valueNotFound)) }
            }
        }
    }
    
    let langDAO = LangDAO()
    func getLangs(_ completionBlock: @escaping LangsBlock) {
        performInRealmQueue { [weak self] in
            if let langs = self?.langDAO.fetchAll(), langs.count > 0 {
                self?.performInMainQueue { completionBlock(Result.value(langs)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    let directionDAO = DirectionDAO()
    func getDirections(_ completionBlock: @escaping DirectionsBlock) {
        performInRealmQueue { [weak self] in
            if let directions = self?.directionDAO.fetchAll(), directions.count > 0 {
                self?.performInMainQueue { completionBlock(Result.value(directions)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func getPairs(_ lang: Lang, _ completionBlock: @escaping LangsBlock) {
        performInRealmQueue { [weak self] in
            let dirPredicate = NSPredicate(format: "value BEGINSWITH %@", lang.abbr)
            if let directions = self?.directionDAO.fetchAllWithPredicate(dirPredicate), directions.count > 0 {
                let abbrLangs = directions.flatMap({ $0.value.substring(from: "-")}).unique()
                self?.getLangsBy(list: abbrLangs, completionBlock)
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func getSourceLangs(_ completionBlock: @escaping LangsBlock) {
        self.getDirections { [weak self] result in
            switch result {
            case .value(let directions):
                let abbrLangs = directions.flatMap({ $0.value.substring(to: "-")}).unique()
                self?.getLangsBy(list: abbrLangs, completionBlock)
            case .error: self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func getTargetLangs(_ pair: Lang, _ completionBlock: @escaping LangsBlock) {
        performInRealmQueue { [weak self] in
            let dirPredicate = NSPredicate(format: "value BEGINSWITH %@", pair.abbr)
            if let directions = self?.directionDAO.fetchAllWithPredicate(dirPredicate), directions.count > 0 {
                let abbrLangs = directions.flatMap({ $0.value.substring(from: "-")}).unique()
                self?.getLangsBy(list: abbrLangs, completionBlock)
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func getLang(_ abbr: String, _ completionBlock: @escaping LangBlock) {
        performInRealmQueue { [weak self] in
            if let lang = self?.langDAO.fetchAll(withParams: ["abbr": abbr as AnyObject]).first {
                self?.performInMainQueue { completionBlock(Result.value(lang)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func getTranslatedText(_ completionBlock: @escaping TranslatedBlock) {
        performInRealmQueue { [weak self] in
            if let texts = self?.translatedTextDao.fetchAll(), texts.count > 0 {
                self?.performInMainQueue { completionBlock(Result.value(texts)) }
            } else {
                self?.performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
            }
        }
    }
    
    func removeTranslatedText(_ text: TranslatedText) {
        performInRealmQueue { [weak self] in
            self?.translatedTextDao.delete(text)
        }
    }
    
    // MARK: Private helpers
    func getLangsBy(list: [String], _ completionBlock: @escaping LangsBlock) {
        let langsPredicate = NSPredicate(format: "abbr IN %@", list)
        let langs = self.langDAO.fetchAllWithPredicate(langsPredicate)
        if langs.count > 0 {
            performInMainQueue { completionBlock(Result.value(langs)) }
        } else {
            performInMainQueue { completionBlock(Result.error(Errors.noFetchedData)) }
        }
    }

}
