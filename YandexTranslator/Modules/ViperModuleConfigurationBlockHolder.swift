//
//  ViperModuleConfigurationBlockHolder.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 18.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

typealias ConfigurationBlock = (ViperModuleInput) -> Void

struct ViperModuleConfigurationBlockHolder {
    let configurationBlock: ConfigurationBlock?
}
