//
//  HistoryHistoryInitializer.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 02/03/2017.
//  Copyright © 2017 igyo. All rights reserved.
//

import UIKit

class HistoryModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var historyViewController: HistoryViewController!

    override func awakeFromNib() {

        let configurator = HistoryModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: historyViewController)
    }

}
