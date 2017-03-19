//
//  DictionaryDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct DictionaryDAO: DAO {
    
    func toEntity(_ entry: DictionaryEntry) -> Dictionary {
        return Dictionary(text: entry.text,
                          direction: entry.direction,
                          definitions: DefinitionDAO().toEntitiesArray(entry.definitions)
        )
    }
    
    func toEntry(_ entity: Dictionary) -> DictionaryEntry {
        let entry = DictionaryEntry()
        entry.text = entity.text
        entry.direction = entity.direction
        entry.definitions = DefinitionDAO().toEntriesList(entity.definitions)
        return entry
    }
    
    func delete(_ entity: Dictionary) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Dictionary, block: @escaping (DictionaryEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
}
