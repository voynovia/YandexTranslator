//
//  TranslateTranslateRouter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

class TranslateRouter: TranslateRouterInput {
    
    weak var transitionHandler: ViperModuleTransitionHandler!
    var presenter: TranslateModuleInput!
    
    internal func openLanguageSelection(_ selectableLanguages: SelectableLanguages, pair: Lang? = nil) {
        transitionHandler.openModule(usingSegue: "selectLanguage", { (moduleInput) in
            guard let languageInput = moduleInput as? LanguageModuleInput else { fatalError("invalid module type") }
            languageInput.setup(selectableLanguages, pair: pair)
            languageInput.moduleInput = self.presenter
        })
    }

}
