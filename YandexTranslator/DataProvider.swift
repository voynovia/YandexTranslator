//
//  DataProvider.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

extension DispatchQueue {
    public static let realmBackgroundQueue = DispatchQueue(label: "io.realm.realm.background")
}

protocol DataProvider { }

extension DataProvider {
    func performInRealmQueue(_ block: @escaping () -> Void) {
        DispatchQueue.realmBackgroundQueue.async {
            block()
        }
    }
    func performInMainQueue(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
}
