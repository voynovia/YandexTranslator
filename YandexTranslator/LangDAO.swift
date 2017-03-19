//
//  LangDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct LangDAO: DAO {
    
    var sortField: String? = "name"
    var ascending: Bool = true
    
    func toEntity(_ entry: LangEntry) -> Lang {
        return Lang(abbr: entry.abbr, name: entry.name)
    }
    
    func toEntry(_ entity: Lang) -> LangEntry {
        let entry = LangEntry()
        entry.abbr = entity.abbr
        entry.name = entity.name
        return entry
    }
    
    func delete(_ entity: Lang) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
    
    func update(_ entity: Lang, block: @escaping (LangEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
}
