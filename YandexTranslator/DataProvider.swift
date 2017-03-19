//
//  DataProvider.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

protocol DataProvider { }

extension DataProvider {
    func performInBackground(_ block: @escaping () -> ()) {
        OperationQueue().addOperation { block() }
    }
    func performOnMainThread(_ block: @escaping () -> ()) {
        OperationQueue.main.addOperation { block() }
    }
    
    func performInRealmQueue(_ block: @escaping () -> ()) {
        DispatchQueue.realmBackgroundQueue.async {
            block()
        }
    }
    func performInMainQueue(_ block: @escaping () -> ()) {
        DispatchQueue.main.async {
            block()
        }
    }
}
