//
//  HistoryHistoryRouter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

class HistoryRouter: HistoryRouterInput {
    
    weak var transitionHandler: ViperModuleTransitionHandler?
    
    internal func openTranslatedText(text: TranslatedText) {

        transitionHandler?.openModule(usingTabBarIndex: 0, { (moduleInput) in
            guard let translateModuleInput = moduleInput as? TranslateModuleInput else { fatalError("invalid module type") }
            translateModuleInput.didSetTranslatedText(text)
        })
        
    }

}
