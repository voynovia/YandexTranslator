//
//  TranslateTranslatePresenter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

class TranslatePresenter: TranslateModuleInput, TranslateViewOutput, TranslateInteractorOutput {
    
    var moduleInput: ViperModuleInput?
    
    weak var view: TranslateViewInput!
    var interactor: TranslateInteractorInput!
    var router: TranslateRouterInput!

    private let settings = UserDefaults.standard
    
    var selectableLanguages: SelectableLanguages!
    
    var sourceLanguage: Lang! {
        didSet {
            view.setTitleSourceLanguage(sourceLanguage)
            settings.set(sourceLanguage.abbr, forKey: "sourceLanguage")
        }
    }
    var targetLanguage: Lang! {
        didSet {
            view.setTitleTargetLanguage(targetLanguage)
            settings.set(targetLanguage.abbr, forKey: "targetLanguage")
        }
    }
    
    // MARK: TranslateModuleInput
    internal func didSelectLanguage(_ lang: Lang) {
        if selectableLanguages == SelectableLanguages.source {
            self.sourceLanguage = lang
            interactor.getPair(lang)
        } else {
            self.targetLanguage = lang
        }
    }
    internal func didSetTranslatedText(_ text: TranslatedText) {
        sourceLanguage = text.source
        targetLanguage = text.target
        view.setupSourceText(text.text)
        didEditSourceText(text: text.text)
    }
    
    // MARK: TranslateViewOutput
    func viewIsReady() {
        interactor.getLang(.source, settings.string(forKey: "sourceLanguage") ?? "en")
        interactor.getLang(.target, settings.string(forKey: "targetLanguage") ?? "ru")
        
        if settings.string(forKey: "sourceLanguage") == nil {
            settings.set(true, forKey: "isDetect")
            settings.set(true, forKey: "isUseReturn")
            settings.set(true, forKey: "isShowDictionary")
        }
    }
    
    func didEditSourceText(text: String) {
        let text = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        interactor.translate(text: text, direction: "\(sourceLanguage.abbr!)-\(targetLanguage.abbr!)")
        if settings.bool(forKey: "isShowDictionary") {
            interactor.translate(word: text, direction: "\(sourceLanguage.abbr!)-\(targetLanguage.abbr!)")
        }
    }
    internal func toSelectLanguage(selectableLanguages: SelectableLanguages) {
        self.selectableLanguages = selectableLanguages
        if selectableLanguages == SelectableLanguages.source {
            self.router.openLanguageSelection(selectableLanguages, pair: nil)
        } else {
            self.router.openLanguageSelection(selectableLanguages, pair: sourceLanguage)
        }
    }
    internal func changeDirection() {
        let lang = self.sourceLanguage
        self.sourceLanguage = self.targetLanguage
        self.targetLanguage = lang
    }
    
    // MARK: TranslateInteractorOutput
    internal func didGetDictionary(_ dictionary: Dictionary) {
        view.setupView(withDictionary: dictionary)
    }

    internal func didGetTranslate(_ text: String) {
        view.setupView(withTranslate: text)
    }
    internal func didGetPairs(_ langs: [Lang]) {
        if let lang = self.targetLanguage {            
            if langs.filter({$0.abbr == lang.abbr}).count > 0 { self.targetLanguage = langs[0] }
        } else {
            self.targetLanguage = langs[0]
        }
    }
    internal func didGetLang(_ selectableLanguage: SelectableLanguages, _ lang: Lang) {
        switch selectableLanguage {
        case .source: self.sourceLanguage = lang
        case .target: self.targetLanguage = lang
        }
    }

}
