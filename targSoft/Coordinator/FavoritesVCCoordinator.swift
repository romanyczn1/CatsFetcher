//
//  FavoritesVCCoordinator.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

class FavoritesViewControllerCoordinator: Coordinator {
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoritesViewController = FavoritesViewController()
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
}
