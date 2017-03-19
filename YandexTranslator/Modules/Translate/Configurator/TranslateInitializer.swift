//
//  TranslateTranslateInitializer.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class TranslateModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var translateViewController: TranslateViewController!

    override func awakeFromNib() {

        let configurator = TranslateModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: translateViewController)
    }

}
