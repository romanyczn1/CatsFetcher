//
//  CatsVCViewModel.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import Foundation
import Combine

protocol CatsViewControllerViewModelType {
    var catsItem: CurrentValueSubject<[Cat], Never> { get }
    func getCatsCount() -> Int
    func getCatCellViewModel(for indexPath: IndexPath) -> CatCellViewModelType
    func catsEndReached()
}

final class CatsViewControllerViewModel: CatsViewControllerViewModelType {
    
    private let catsFetcher: CatsDataFetcher = CatsFetcher()
    private let imageStoringService: ImageStoringServiceType = ImageStoringService()
    let catsItem = CurrentValueSubject<[Cat], Never>([])
    private let pageSize: Int = 10
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchCats()
    }
    
    private func fetchCats() {
        catsFetcher.fetchCats(pageNumber: catsItem.value.count / 10) { [weak self] (newCats, error) in
            DispatchQueue.main.async {
                if newCats != nil {
                    var oldCats = self?.catsItem.value
                    oldCats?.append(contentsOf: newCats!)
                    self?.catsItem.send(oldCats!)
                } else {
                    print("ERRROOORRRR")
                }
            }
        }
    }
    
    func getCatsCount() -> Int {
        return catsItem.value.count
    }
    
    func getCatCellViewModel(for indexPath: IndexPath) -> CatCellViewModelType {
        let cellViewModel = CatCellViewModel(cat: catsItem.value[indexPath.row])
        
        cellViewModel.didAddFavoriteCat
            .handleEvents( receiveOutput: { (cat) in
                CatsStorageService.shared.saveCat(cat: cat) { success in
                    if success == true {
                        //update favoritesVC
                    }
                }
            })
            .sink { _ in }
            .store(in: &subscriptions)
        
        cellViewModel.downloadImageTapped
            .handleEvents( receiveOutput: { [weak self] (url) in
                self?.imageStoringService.saveImage(imageUrl: url)
            })
            .sink { _ in }
            .store(in: &subscriptions)
        return cellViewModel
    }
    
    func catsEndReached() {
        fetchCats()
    }
    
    
}
