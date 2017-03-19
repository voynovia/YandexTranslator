//
//  LanguageLanguagePresenter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

class LanguagePresenter: LanguageModuleInput, LanguageViewOutput, LanguageInteractorOutput {
    
    weak var view: LanguageViewInput!
    var interactor: LanguageInteractorInput!
    var router: LanguageRouterInput!

    internal var moduleInput: ViperModuleInput? {
        didSet {
            if let input = moduleInput as? TranslateModuleInput {
                translateInput = input
            }
        }
    }
    
    var translateInput: TranslateModuleInput!
    
    func viewIsReady() {
        view.setHeader(header)
    }
    
    // MARK: LanguageModuleInput
    var header: String = "Язык"
    var selectableLanguages: SelectableLanguages!
    internal func setup(_ selectableLanguages: SelectableLanguages, pair: Lang?) {
        self.selectableLanguages = selectableLanguages
        switch selectableLanguages {
        case .source:
            header = "Язык оригинала"
            interactor.getSourceLangs()
        case .target:
            header = "Язык перевода"
            interactor.getTargetLangs(pair!)
        }
    }
    
    // MARK: LanguageViewOutput
    internal func backToTranslate() {
        router.backToTranslate()
    }
    internal func setLanguage(withLang lang: Lang) {
        translateInput.didSelectLanguage(lang)
        router.backToTranslate()
    }
    
    // MARK: LanguageInteractorOutput
    internal func didGetLangs(_ langs: [Lang]) {
        view.setupView(withLangs: langs)
    }
}
