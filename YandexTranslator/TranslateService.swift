//
//  TranslateService.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

protocol TranslateService {
    func getLangs(servicePolicy: ServicePolicy, completionBlock: @escaping LangsBlock)
    func getDirections(servicePolicy: ServicePolicy, completionBlock: @escaping DirectionsBlock)
    func detect(_ text: String, servicePolicy: ServicePolicy, completionBlock: @escaping DetectBlock)
    func translate(_ text: String, lang: String, servicePolicy: ServicePolicy, completionBlock: @escaping TranslateBlock)
    func dictionary(_ text: String, direction: String, servicePolicy: ServicePolicy, completionBlock: @escaping DictionaryBlock)
    
    func getPairs(_ lang: Lang, completionBlock: @escaping LangsBlock)
    func getSourceLangs(completionBlock: @escaping LangsBlock)
    func getTargetLangs(_ pair: Lang, completionBlock: @escaping LangsBlock)
    
    func getLang(_ abbr: String, completionBlock: @escaping LangBlock)
}

class TranslateServiceImpl: TranslateService {
    
    private let networkDataProvider: NetworkDataProvider
    private let offlineDataProvider: OfflineDataProvider
    
    init(networkDataProvider: NetworkDataProvider, offlineDataProvider: OfflineDataProvider) {
        self.networkDataProvider = networkDataProvider
        self.offlineDataProvider = offlineDataProvider
    }
    
    // MARK: TranslateService
    
    internal func detect(_ text: String, servicePolicy: ServicePolicy, completionBlock: @escaping DetectBlock) {
        switch servicePolicy {
        case .networkOnly:
            networkDataProvider.detect(text, { result in
                completionBlock(result)
            })
        case .cacheOnly:
            completionBlock(Result.error(Errors.notImplemented))
        }
    }

    internal func getLangs(servicePolicy: ServicePolicy, completionBlock: @escaping LangsBlock) {
        switch servicePolicy {
        case .networkOnly:
            networkDataProvider.getLangsDirections({ [weak self] result in
                self?.handleGetLangsDirections(result)
                completionBlock(result.0)
            })
        case .cacheOnly:
            offlineDataProvider.getLangs(completionBlock)
        }
    }
    
    internal func getDirections(servicePolicy: ServicePolicy, completionBlock: @escaping DirectionsBlock) {
        switch servicePolicy {
        case .networkOnly:
            networkDataProvider.getLangsDirections({ [weak self] result in
                self?.handleGetLangsDirections(result)
                completionBlock(result.1)
            })
        case .cacheOnly:
            offlineDataProvider.getDirections(completionBlock)
        }
    }
    
    internal func translate(_ text: String, lang: String, servicePolicy: ServicePolicy, completionBlock: @escaping TranslateBlock) {
        switch servicePolicy {
        case .networkOnly:
            networkDataProvider.translate(text, lang: lang, { [weak self] result in
                self?.handleGetTranslate(text, result)
                completionBlock(result)
            })
        case .cacheOnly:
            offlineDataProvider.translate(text, direction: lang, completionBlock)
        }
    }
    
    internal func dictionary(_ text: String, direction: String, servicePolicy: ServicePolicy, completionBlock: @escaping DictionaryBlock) {
        switch servicePolicy {
        case .networkOnly:
            networkDataProvider.dictionary(text, direction: direction, { [weak self] result in
                self?.handleGetDictionary(result)
                completionBlock(result)
            })
        case .cacheOnly:
            offlineDataProvider.dictionary(text, direction: direction, completionBlock)
        }
    }

    internal func getPairs(_ lang: Lang, completionBlock: @escaping LangsBlock) {
        offlineDataProvider.getPairs(lang, completionBlock)
    }

    internal func getSourceLangs(completionBlock: @escaping LangsBlock) {
        offlineDataProvider.getSourceLangs(completionBlock)
    }
    internal func getTargetLangs(_ pair: Lang, completionBlock: @escaping LangsBlock) {
        offlineDataProvider.getTargetLangs(pair, completionBlock)
    }
    func getLang(_ abbr: String, completionBlock: @escaping LangBlock) {
        offlineDataProvider.getLang(abbr, completionBlock)
    }
        
    // MARK: Private helpers

    private func handleGetLangsDirections(_ result: (Result<[Lang]>, Result<[Direction]>)) {
        switch result.0 {
        case .value(let value):
            LangDAO().createWithUpdate(value)
        case .error(let error):
            print(error.localizedDescription)
        }
        switch result.1 {
        case .value(let value):
            DirectionDAO().createWithUpdate(value)
        case .error(let error):
            print(error.localizedDescription)
        }
    }
    
    private func handleGetDictionary(_ result: Result<Dictionary>) {
        switch result {
        case .value(let dictionary):
            if dictionary.definitions.count > 0 {
                DictionaryDAO().createWithUpdate([dictionary])
            }
        case .error(let error):
            print(error.localizedDescription)
        }
    }
    
    private func handleGetTranslate(_ text: String, _ result: Result<TranslateResponse>) {
        switch result {
        case .value(let response):
            let sourceLang = LangDAO().fetchAll(withParams: ["abbr": response.lang.substring(to: "-") as AnyObject]).first
            let targetLang = LangDAO().fetchAll(withParams: ["abbr": response.lang.substring(from: "-") as AnyObject]).first
            let translatedText = TranslatedText(text: text,
                                                direction: response.lang,
                                                source: sourceLang!,
                                                target: targetLang!,
                                                translate: response.text.first!,
                                                date: Date(), isHistory: true, isFavourite: false)
            TranslatedTextDAO().createWithUpdate([translatedText])
        case .error(let error):
            print(error.localizedDescription)
        }
    }
}
