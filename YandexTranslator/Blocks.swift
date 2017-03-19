//
//  Blocks.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

typealias DetectBlock = (Result<DetectResponse>) -> Void
typealias TranslateBlock = (Result<TranslateResponse>) -> Void

typealias DictionaryBlock = (Result<Dictionary>) -> Void

typealias LangBlock = (Result<Lang>) -> Void
typealias LangsBlock = (Result<[Lang]>) -> Void
typealias DirectionsBlock = (Result<[Direction]>) -> Void
typealias LangsDirectionsBlock = (Result<[Lang]>, Result<[Direction]>) -> Void

typealias TranslatedBlock = (Result<[TranslatedText]>) -> Void
