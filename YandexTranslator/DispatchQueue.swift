//
//  Realm.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 18.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

//import RealmSwift
//

import Foundation

extension DispatchQueue {
    public static let realmBackgroundQueue = DispatchQueue(label: "io.realm.realm.background")
}

//extension ThreadSafeReference {
//    func async(write: Bool = false, queue: DispatchQueue = .realmBackgroundQueue,
//               errorHandler: ((Realm.Error) -> Void)? = nil,
//               block: @escaping (Realm, Confined) -> Void) {
//        queue.async {            
//            do {
//                let realm = try Realm()
//                guard let object = realm.resolve(self) else { return }
//                if write { realm.beginWrite() }
//                block(realm, object)
//                if write { try realm.commitWrite() }
//            } catch {
//                errorHandler?(error as! Realm.Error)
//            }
//        }
//    }
//}
