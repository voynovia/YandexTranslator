//
//  DAO.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 04.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import RealmSwift

public enum DAOResult {
    case success
    case error(Error)
}

protocol Entity {}
class Entry: Object {
    dynamic var id: String = ""
    override static func primaryKey() -> String? { return "id" }
}

protocol DAO {
    associatedtype Entity
    associatedtype Entry
    
    // MARK: Sorting
    var sortField: String? { get }
    var ascending: Bool { get }
    
    // MARK: Entry <-> Entity
    func toEntry(_ entity: Entity) -> Entry
    func toEntity(_ entry: Entry) -> Entity
    func toEntries(_ entities: [Entity]) -> [Entry]
    func toEntities(_ entries: [Entry]) -> [Entity]
    
    // MARK: CRUD
    func createWithUpdate(_ entities: [Entity])
    func update(_ entity: Entity, block: @escaping (Entry) -> Void)
    func delete(_ entity: Entity)
    func deleteAll()
    func fetchAll(withParams params: [String: AnyObject]?) -> [Entity]
    func fetchEntity(withId id: AnyObject) -> Entity?
}

extension DAO where Self.Entry: Object {
    
    // MARK: Sorting
    var sortField: String? { return nil }
    var ascending: Bool { return false }
    
    // MARK: Entry <-> Entity
    func toEntries(_ entities: [Entity]) -> [Entry] {
        return entities.map { toEntry($0) }
    }
    
    func toEntities(_ entries: [Entry]) -> [Entity] {
        return entries.map { toEntity($0) }
    }
    
    func toEntriesList(_ entities: [Entity]?) -> List<Entry> {
        guard let entities = entities else { return List([]) }
        return List(self.toEntries(entities))
    }
    
    func toEntitiesArray(_ list: List<Entry>?) -> [Entity] {
        guard let list = list else { return [] }
        return self.toEntities(Array(list))
    }
    
    // MARK: CRUD
    func createWithUpdate(_ entities: [Entity]) {
        let entries = toEntries(entities)
        let realm = try! Realm()
        try! realm.write {
            realm.add(entries, update: true)
        }
    }
    
    func writeHelper(primaryKey: String,
                      queue: DispatchQueue = .realmBackgroundQueue,
                      errorHandler: ((Error) -> Void)? = nil,
                      block: @escaping (Realm, Entry) -> Void) {
        
        helper(write: true, queue: queue, errorHandler: errorHandler) { (realm) in
            guard let object = realm.object(ofType: Entry.self, forPrimaryKey: primaryKey) else { return }
            block(realm, object)
        }
    }
    
    func helper(write: Bool = false,
                queue: DispatchQueue = .realmBackgroundQueue,
                errorHandler: ((Error) -> Void)? = nil,
                block: @escaping (Realm) -> Void) {
        queue.async {
            do {
                let realm = try Realm()
                if write { realm.beginWrite() }
                block(realm)
                if write { try realm.commitWrite() }
            } catch {
                errorHandler?(error)
            }
        }
    }
        
    func deleteAll() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(Entry.self))
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchAllWithPredicate(_ predicate: NSPredicate) -> [Entity] {
        return toEntities(fetchAllEntriesWithPredicate(predicate))
    }
    
    func fetchAll(withParams params: [String: AnyObject]? = nil) -> [Entity] {
        return toEntities(fetchAllEntriesWithParams(params))
    }
    
    func fetchEntity(withId id: AnyObject) -> Entity? {
        if let entry = fetchEntryWithId(id) { return toEntity(entry) } else { return nil }
    }
    
    // MARK: Private helpers
    fileprivate func fetchAllEntriesWithPredicate(_ predicate: NSPredicate) -> [Entry] {
        let realm = try! Realm()
        var results = realm.objects(Entry.self)
        if let sortField = sortField { results = results.sorted(byKeyPath: sortField) }
        results = results.filter(predicate)
        return resultsToEntries(results)
    }
    
    fileprivate func resultsToEntries(_ results: Results<Entry>) -> [Entry] {
        var entries = [Entry]()
        for entry in results { entries.append(entry) }
        return entries
    }
    
    fileprivate func fetchAllEntriesWithParams(_ params: [String: AnyObject]?) -> [Entry] {
        let realm = try! Realm()
        var results = realm.objects(Entry.self)
        if let sortField = sortField { results = results.sorted(byKeyPath: sortField, ascending: ascending) }
        if let filterString = predicateStringForParameters(params) , !filterString.isEmpty {
            results = results.filter(filterString)
        }
        return results.map { $0 }
    }
    
    fileprivate func fetchEntryWithId(_ id: AnyObject) -> Entry? {
        let realm = try! Realm()
        if let result = realm.object(ofType: Entry.self, forPrimaryKey: id as AnyObject) { return result } else { return nil }
    }
    
    fileprivate func predicateStringForParameters(_ parameters: [String: AnyObject]?) -> String? {
        guard let parameters = parameters else { return nil }
        var strings = [String]()
        for (key, value) in parameters {
            if let value = value as? String {
                strings.append("\(key) CONTAINS[c] '\(value)'")
            } else {
                strings.append("\(key) = \(value)")
            }
        }
        return strings.joined(separator: " OR ")
    }
}
