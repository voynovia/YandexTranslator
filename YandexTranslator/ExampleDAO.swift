//
//  ExampleDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct ExampleDAO: DAO {
    
    func toEntity(_ entry: ExampleEntry) -> Example {
        return Example(text: entry.text,
                       translation: TranslationDAO().toEntitiesArray(entry.translation))
    }
    
    func toEntry(_ entity: Example) -> ExampleEntry {
        let entry = ExampleEntry()
        entry.text = entity.text
        entry.translation = TranslationDAO().toEntriesList(entity.translation)
        return entry
    }
    
    func delete(_ entity: Example) {
        writeHelper(primaryKey: entity.text) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Example, block: @escaping (ExampleEntry) -> Void) {
        writeHelper(primaryKey: entity.text) { (_, entry) in
            block(entry)
        }
    }
}
