//
//  SynonymDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct SynonymDAO: DAO {
        
    func toEntity(_ entry: SynonymEntry) -> Synonym {
        return Synonym(text: entry.text, pos: entry.pos, gen: entry.gen)
    }
    
    func toEntry(_ entity: Synonym) -> SynonymEntry {
        let entry = SynonymEntry()
        entry.text = entity.text
        entry.pos = entity.pos
        entry.gen = entity.gen
        return entry
    }
    
    func delete(_ entity: Synonym) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Synonym, block: @escaping (SynonymEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
}
