//
//  CatsLocalDataFetcher.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import GRDB

final class CatsStorageService {
    
    static let dbQueue: DatabaseQueue = {
        let databaseURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
        let dbQueue = try! DatabaseQueue(path: databaseURL.path)
        try! dbQueue.write { db in
            try db.create(table: "cat", temporary: false, ifNotExists: true, body: { t in
                t.autoIncrementedPrimaryKey("id")
                t.column("url", .text).notNull().unique()
            })
        }
        return dbQueue
    }()
    
    static let shared = CatsStorageService()
    
    private init() {}
    
    func saveCat(cat: Cat, completion: @escaping (Bool) -> ()) {
        do {
            try CatsStorageService.dbQueue.write { db in
                try Cat(url: cat.url).insert(db)
                completion(true)
            }
        } catch DatabaseError.SQLITE_CONSTRAINT_UNIQUE {
            print("cat already in favorites")
            completion(false)
        } catch {
            print("some error")
            completion(false)
        }
    }
    
    func fetchCats(completion: @escaping ([Cat]?, Error?) -> ()) {
        do {
            let cats: [Cat] = try CatsStorageService.dbQueue.read { db in
                try Cat.fetchAll(db)
            }
            completion(cats, nil)
        } catch {
            completion(nil, error)
        }
    }
}
