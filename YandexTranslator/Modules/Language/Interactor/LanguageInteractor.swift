//
//  LanguageLanguageInteractor.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

class LanguageInteractor: LanguageInteractorInput {
    weak var output: LanguageInteractorOutput!

    private var translateService = TranslateServiceAssemblyImpl.service()
    
    internal func getSourceLangs() {
        translateService.getSourceLangs { [weak self] langs in
            switch langs {
            case .value(let value): self?.output.didGetLangs(value)
            case .error(let error): print(error.localizedDescription)
            }
        }
    }
      
    internal func getTargetLangs(_ pair: Lang) {
        translateService.getTargetLangs(pair) { [weak self] langs in
            switch langs {
            case .value(let value): self?.output.didGetLangs(value)
            case .error(let error): print(error.localizedDescription)
            }
        }
    }
        
}
