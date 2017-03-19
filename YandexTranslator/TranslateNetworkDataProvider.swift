//
//  TranslateNetworkDataProvider.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol NetworkDataProvider: DataProvider {
    func getLangsDirections(_ completionBlock: @escaping LangsDirectionsBlock)
    func detect(_ text: String, _ completionBlock: @escaping DetectBlock)
    func translate(_ text: String, lang: String, _ completionBlock: @escaping TranslateBlock)
    func dictionary(_ text: String, direction: String, _ completionBlock: @escaping DictionaryBlock)
}

class TranslateNetworkDataProvider: NetworkDataProvider {
    let transport: Transport
    
    init(transport: Transport) {
        self.transport = transport
    }
    
    // MARK: Translate Data Provider
    
    internal func detect(_ text: String, _ completionBlock: @escaping DetectBlock) {
        performInBackground { [weak self] in
            var request = Request(TranslateRequest.detect)
            request.parameters?["text"] = text
            self?.transport.requestObject(try! request.asURLRequest(), type: DetectResponse.self, completionBlock: { [weak self] result in
                switch result {
                case .value(let object): self?.performOnMainThread { completionBlock(Result.value(object)) }
                case .error(let error): self?.performOnMainThread { completionBlock(Result.error(error)) }
                }
            })
        }
    }
    
    internal func getLangsDirections(_ completionBlock: @escaping LangsDirectionsBlock) {
        performInBackground { [weak self] in
            self?.transport.requestJSON(try! Request(TranslateRequest.langs).asURLRequest(), completionBlock: { [weak self] result in
                switch result {
                case .value(let value): self?.handleTransportLangsData(value, completionBlock)
                case .error(let error): self?.performOnMainThread { completionBlock(Result.error(error), Result.error(error)) }
                }
            })
        }
    }
    
    internal func translate(_ text: String, lang: String, _ completionBlock: @escaping TranslateBlock) {
        performInBackground { [weak self] in
            var request = Request(TranslateRequest.translate)
            request.parameters?["text"] = text
            request.parameters?["lang"] = lang
            self?.transport.requestObject(try! request.asURLRequest(), type: TranslateResponse.self, completionBlock: { [weak self] result in
                switch result {
                case .value(let object): self?.performOnMainThread { completionBlock(Result.value(object)) }
                case .error(let error): self?.performOnMainThread { completionBlock(Result.error(error)) }
                }
            })
        }
    }
    
    internal func dictionary(_ text: String, direction: String, _ completionBlock: @escaping DictionaryBlock) {
        performInBackground { [weak self] in
            var request = Request(TranslateRequest.dictionary)
            request.parameters?["text"] = text
            request.parameters?["lang"] = direction
            self?.transport.requestArray(try! request.asURLRequest(), keyPath: "def", type: Definition.self, completionBlock: { [weak self] result in
                switch result {
                case .value(let value): self?.handleTransportDictionaryData(text: text, direction: direction, array: value, completionBlock)
                case .error(let error): self?.performOnMainThread { completionBlock(Result.error(error)) }
                }
            })
        }
    }
    
    // MARK: Private helpers
    
    private func handleTransportLangsData(_ result: Any, _ completionBlock: @escaping LangsDirectionsBlock) {
        var directions = [Direction]()
        var langs = [Lang]()
        let json = SwiftyJSON.JSON(result)
        let dirsJSON = json["dirs"]
        for dir in dirsJSON {
            let direction = Direction(value: dir.1.stringValue)
            directions.append(direction)
        }
        let langsJSON = json["langs"]
        for langJSON in langsJSON {
            let lang = Lang(abbr: langJSON.0, name: langJSON.1.stringValue)
            langs.append(lang)
        }
        performOnMainThread { completionBlock(Result.value(langs), Result.value(directions)) }
    }
    
    private func handleTransportDictionaryData(text: String, direction: String, array: [Definition], _ completionBlock: @escaping DictionaryBlock) {
        var definitions = [Definition]()
        for item in array {
            var definition = item
            definition.language = direction.substring(from: "-")
            definitions.append(definition)
        }
        let dictionary = Dictionary(text: text.lowercased(), direction: direction.lowercased(), definitions: definitions)
        performOnMainThread { completionBlock(Result.value(dictionary)) }
    }
}
