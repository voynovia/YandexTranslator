//
//  DirectionDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct DirectionDAO: DAO {
        
    func toEntity(_ entry: DirectionEntry) -> Direction {
        return Direction(value: entry.value)
    }
    
    func toEntry(_ entity: Direction) -> DirectionEntry {
        let entry = DirectionEntry()
        entry.value = entity.value
        return entry
    }
    
    func delete(_ entity: Direction) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Direction, block: @escaping (DirectionEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
}
