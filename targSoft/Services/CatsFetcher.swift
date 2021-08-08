//
//  CatsFetcher.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import Foundation

protocol CatsDataFetcher: class {
    func fetchCats(pageNumber: Int, completion: @escaping ([Cat]?, Error?) -> ())
}

final class CatsFetcher: CatsDataFetcher {
    
    private let netwotkService: Networking
    
    init() {
        netwotkService = NetworkService()
    }
    
    func fetchCats(pageNumber: Int, completion: @escaping ([Cat]?, Error?) -> ()) {
        netwotkService.request(forString: "https://api.thecatapi.com/v1/images/search?page=1&size=small&limit=10") { (data, error) in
            
            if let data = data {
                do {
                    let cats = try JSONDecoder().decode([Cat].self, from: data)
                    completion(cats, nil)
                } catch {
                    completion(nil, error)
                }
                
            } else {
                completion(nil, error)
            }
        }
    }
}
