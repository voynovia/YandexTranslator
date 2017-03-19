//
//  TranslateTranslateConfigurator.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class TranslateModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TranslateViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: TranslateViewController) {

        let router = TranslateRouter()
        let presenter = TranslatePresenter()
        let interactor = TranslateInteractor()

        viewController.output = presenter
        viewController.moduleInput = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.output = presenter
        
        router.transitionHandler = viewController
        router.presenter = presenter
        
    }

}
