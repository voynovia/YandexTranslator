
//  LanguageLanguageConfigurator.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class LanguageModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? LanguageViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: LanguageViewController) {

        let router = LanguageRouter()
        router.transitionHandler = viewController
        
        let presenter = LanguagePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = LanguageInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }

}
