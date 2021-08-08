//
//  CatCellViewModel.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import Combine

protocol CatCellViewModelType {
    var imageURL: String { get }
    func favButtonTapped()
    func downloadButtonTapped()
}

final class CatCellViewModel: CatCellViewModelType {
    
    var cat: Cat
    var imageURL: String {
        return cat.url
    }
    
    let didAddFavoriteCat = PassthroughSubject<Cat, Never>()
    let downloadImageTapped = PassthroughSubject<String, Never>()
    
    init(cat: Cat) {
        self.cat = cat
    }
    
    func favButtonTapped() {
        didAddFavoriteCat.send(cat)
    }
    
    func downloadButtonTapped() {
        downloadImageTapped.send(cat.url)
    }
}
