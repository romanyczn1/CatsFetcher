//
//  FavoriteCatCellViewModel.swift
//  targSoft
//
//  Created by Roman Bukh on 8.08.21.
//


protocol FavoriteCatCellViewModelType {
    var imageURL: String { get }
}

final class FavoriteCatCellViewModel: FavoriteCatCellViewModelType {
    
    var cat: Cat
    var imageURL: String {
        return cat.url
    }
    
    init(cat: Cat) {
        self.cat = cat
    }
}
