//
//  ViperModuleTransitionHandler.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 18.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

protocol ViperModuleTransitionHandler: class {
    
    func openModule(usingSegue segueIdentifier: String, _ configurationBlock: ConfigurationBlock?)
    func openModule(usingTabBarIndex tabBarIndex: Int, _ configurationBlock: ConfigurationBlock?)
    
    func closeCurrentModule(_ animated: Bool)
}

extension ViperModuleTransitionHandler where Self: UIViewController {
    
    func openModule(usingSegue segueIdentifier: String, _ configurationBlock: ConfigurationBlock?) {
        let configuBlockHolder = ViperModuleConfigurationBlockHolder(configurationBlock: configurationBlock)
        performSegue(withIdentifier: segueIdentifier, sender: configuBlockHolder)
    }
    
    func openModule(usingTabBarIndex tabBarIndex: Int, _ configurationBlock: ConfigurationBlock?) {
        self.tabBarController?.selectedIndex = tabBarIndex
        var vc = self.tabBarController?.selectedViewController
        if let navcon = vc as? UINavigationController {
            vc = navcon.visibleViewController ?? vc
        }
        guard let configurationBlock = configurationBlock,
            let moduleInput = (vc as? ViperModuleViewController)?.moduleInput else {
                return
        }
        configurationBlock(moduleInput)
    }
    
    func closeCurrentModule(_ animated: Bool = true) {
        dismiss(animated: animated, completion: nil)
    }
        
}
