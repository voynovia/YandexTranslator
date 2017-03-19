//
//  TranslateTranslateInteractor.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

class TranslateInteractor: TranslateInteractorInput {

    weak var output: TranslateInteractorOutput!

    private var translateService = TranslateServiceAssemblyImpl.service()
    
    func detect(text: String) {
        translateService.detect(text, servicePolicy: .networkOnly, completionBlock: { (detectedLang) in
            print("interactor detect:", detectedLang)
        })
    }
    
    func getLangs() {
        translateService.getLangs(servicePolicy: .cacheOnly) { (langs) in
            print("interactor getLangs:", langs)
        }
    }
    
    func translate(text: String, direction: String) {
        translateService.translate(text, lang: direction, servicePolicy: .cacheOnly) { [weak self] translate in
            switch translate {
            case .value(let value): self?.output.didGetTranslate(value.text.first!)
            case .error:
                self?.translateService.translate(text, lang: direction, servicePolicy: .networkOnly) { [weak self] translate in
                    switch translate {
                    case .value(let value): self?.output.didGetTranslate(value.text.first!)
                    case .error(let error): print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func translate(word: String, direction: String) {
        translateService.dictionary(word, direction: direction, servicePolicy: .cacheOnly) { [weak self] dictionary in
            switch dictionary {
            case .value(let value): self?.output.didGetDictionary(value)
            case .error:
                self?.translateService.dictionary(word, direction: direction, servicePolicy: .networkOnly) { [weak self] dictionary in
                    switch dictionary {
                    case .value(let value): self?.output.didGetDictionary(value)
                    case .error(let error): print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getPair(_ lang: Lang) {
        translateService.getPairs(lang) { [weak self] langs in
            switch langs {
            case .value(let value): self?.output.didGetPairs(value)
            case .error(let error): print(error.localizedDescription)
            }
        }
    }
    
    func getLang(_ selectableLanguage: SelectableLanguages, _ abbr: String) {
        translateService.getLang(abbr) { [weak self] result in
            switch result {
            case .value(let value): self?.output.didGetLang(selectableLanguage, value)
            case .error:
                self?.translateService.getLangs(servicePolicy: .networkOnly, completionBlock: { [weak self] result in
                    switch result {
                    case .value: self?.getLang(selectableLanguage, abbr)
                    case .error(let error): print(error.localizedDescription)
                    }
                })
            }
        }
    }
}
