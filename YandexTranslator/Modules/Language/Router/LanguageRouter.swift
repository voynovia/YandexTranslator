//
//  LanguageLanguageRouter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import Foundation

class LanguageRouter: LanguageRouterInput {
    
    weak var transitionHandler: ViperModuleTransitionHandler?
    
    func backToTranslate() {
        transitionHandler?.closeCurrentModule(true)
    }
    
}
