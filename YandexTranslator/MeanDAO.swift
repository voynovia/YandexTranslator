//
//  MeanDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct MeanDAO: DAO {
        
    func toEntity(_ entry: MeanEntry) -> Mean {
        return Mean(text: entry.text)
    }
    
    func toEntry(_ entity: Mean) -> MeanEntry {
        let entry = MeanEntry()
        entry.text = entity.text
        return entry
    }
    
    func delete(_ entity: Mean) {
        writeHelper(primaryKey: entity.text) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Mean, block: @escaping (MeanEntry) -> Void) {
        writeHelper(primaryKey: entity.text) { (_, entry) in
            block(entry)
        }
    }
}
