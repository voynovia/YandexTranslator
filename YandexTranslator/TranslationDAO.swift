//
//  TranslationDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct TranslationDAO: DAO {
    
    func toEntity(_ entry: TranslationEntry) -> Translation {
        return Translation(text: entry.text,
                           pos: entry.pos,
                           gen: entry.gen,
                           asp: entry.asp,
                           synonyms: SynonymDAO().toEntitiesArray(entry.synonym),
                           means: MeanDAO().toEntitiesArray(entry.mean),
                           examples: ExampleDAO().toEntitiesArray(entry.example)
        )
    }
    
    func toEntry(_ entity: Translation) -> TranslationEntry {
        let entry = TranslationEntry()
        entry.text = entity.text
        entry.pos = entity.pos
        entry.gen = entity.gen
        entry.asp = entity.asp
        
        entry.synonym = SynonymDAO().toEntriesList(entity.synonym)
        entry.mean = MeanDAO().toEntriesList(entity.mean)
        entry.example = ExampleDAO().toEntriesList(entity.example)
        return entry
    }
    
    func delete(_ entity: Translation) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Translation, block: @escaping (TranslationEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
}
