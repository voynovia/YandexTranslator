//
//  Blocks.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

typealias DetectBlock = (Result<DetectResponse>) -> ()
typealias TranslateBlock = (Result<TranslateResponse>) -> ()

typealias DictionaryBlock = (Result<Dictionary>) -> ()

typealias LangBlock = (Result<Lang>) -> ()
typealias LangsBlock = (Result<[Lang]>) -> ()
typealias DirectionsBlock = (Result<[Direction]>) -> ()
typealias LangsDirectionsBlock = (Result<[Lang]>, Result<[Direction]>) -> ()

typealias TranslatedBlock = (Result<[TranslatedText]>) -> ()

