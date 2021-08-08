//
//  FavoritesVCViewModel.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import Foundation
import Combine

protocol FavoritesViewControllerViewModelType {
    var catsItem: CurrentValueSubject<[Cat], Never> { get }
    func fetchCats()
    func getCatsCount() -> Int
    func getCatCellViewModel(for indexPath: IndexPath) -> FavoriteCatCellViewModelType
}

final class FavoritesViewControllerViewModel: FavoritesViewControllerViewModelType {
    
    let catsItem = CurrentValueSubject<[Cat], Never>([])
    var subscriptions = Set<AnyCancellable>()
    
    func fetchCats() {
        CatsStorageService.shared.fetchCats { [weak self] (cats, error) in
            if cats != nil {
                self?.catsItem.send(cats!)
            }
        }
    }
    
    func getCatsCount() -> Int {
        return catsItem.value.count
    }
    
    func getCatCellViewModel(for indexPath: IndexPath) -> FavoriteCatCellViewModelType {
        let cellViewModel = FavoriteCatCellViewModel(cat: catsItem.value[indexPath.row])
        return cellViewModel
    }
    
    
}
