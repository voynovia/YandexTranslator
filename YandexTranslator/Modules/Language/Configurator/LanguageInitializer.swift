//
//  LanguageLanguageInitializer.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 07/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class LanguageModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var languageViewController: LanguageViewController!

    override func awakeFromNib() {

        let configurator = LanguageModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: languageViewController)
    }

}
