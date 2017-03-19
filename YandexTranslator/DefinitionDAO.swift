//
//  DefinitionDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct DefinitionDAO: DAO {
    func toEntity(_ entry: DefinitionEntry) -> Definition {
        return Definition(language: entry.language,
                          text: entry.text,
                          pos: entry.pos,
                          gen: entry.gen,
                          anm: entry.anm,
                          transcription: entry.transcription,
                          translations: TranslationDAO().toEntitiesArray(entry.translation)
        )
    }
    
    func toEntry(_ entity: Definition) -> DefinitionEntry {
        let entry = DefinitionEntry()
        entry.language = entity.language
        entry.text = entity.text
        entry.pos = entity.pos
        entry.gen = entity.gen
        entry.anm = entity.anm
        entry.transcription = entity.transcription
        entry.translation = TranslationDAO().toEntriesList(entity.translation)
        return entry
    }
    
    func delete(_ entity: Definition) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Definition, block: @escaping (DefinitionEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
}
