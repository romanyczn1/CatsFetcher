//
//  Model.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import GRDB

struct Cat: Codable, FetchableRecord, PersistableRecord {
    let url: String
    
    func encode(to container: inout PersistenceContainer) {
        container["url"] = url
    }
}
