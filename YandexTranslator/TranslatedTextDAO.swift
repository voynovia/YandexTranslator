//
//  HistoryDAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 13.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import Foundation

struct TranslatedTextDAO: DAO {
    
    var sortField: String? = "date"
    var ascending: Bool = true
    
    func toEntity(_ entry: TranslatedTextEntry) -> TranslatedText {
        return TranslatedText(text: entry.text,
                              direction: entry.direction,
                              source: LangDAO().toEntity(entry.source),
                              target: LangDAO().toEntity(entry.target),
                              translate: entry.translate,
                              date: entry.date,
                              isHistory: entry.isHistory,
                              isFavourite: entry.isFavourite)
    }
    
    func toEntry(_ entity: TranslatedText) -> TranslatedTextEntry {
        let entry = TranslatedTextEntry()
        entry.text = entity.text
        entry.direction = entity.direction
        entry.source = LangDAO().toEntry(entity.source)
        entry.target = LangDAO().toEntry(entity.target)
        entry.translate = entity.translate
        entry.date = entity.date
        entry.isHistory = entity.isHistory
        entry.isFavourite = entity.isFavourite
        return entry
    }
        
    func getHistory() -> [TranslatedText] {
        return fetchAll(withParams: ["isHistory": true as AnyObject])
    }
    
    func deleteAllHistory() {
        helper { (realm) in
            let entries = realm.objects(TranslatedTextEntry.self).filter({$0.isHistory})
            realm.delete(entries)
        }
    }
    
    func delete(_ entity: TranslatedText) {
        writeHelper(primaryKey: toEntry(entity).id) { (realm, object) in
            realm.delete(object)
        }
    }
        
    func update(_ entity: TranslatedText, block: @escaping (TranslatedTextEntry) -> Void) {
        writeHelper(primaryKey: toEntry(entity).id) { (_, entry) in
            block(entry)
        }
    }
    
}
