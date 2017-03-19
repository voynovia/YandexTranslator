//
//  ViperModuleViewController.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 18.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

class ViperModuleViewController: UIViewController, ViperModuleTransitionHandler {

    var moduleInput: ViperModuleInput?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let configurationBlock = (sender as? ViperModuleConfigurationBlockHolder)?.configurationBlock,
            let moduleInput = (segue.destination as? ViperModuleViewController)?.moduleInput else {
                return
        }
        configurationBlock(moduleInput)
    }
    
}
