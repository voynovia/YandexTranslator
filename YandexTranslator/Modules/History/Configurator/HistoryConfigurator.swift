//
//  HistoryHistoryConfigurator.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class HistoryModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HistoryViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: HistoryViewController) {

        let router = HistoryRouter()
        router.transitionHandler = viewController
        
        let presenter = HistoryPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = HistoryInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
