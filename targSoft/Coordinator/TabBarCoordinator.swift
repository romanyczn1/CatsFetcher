//
//  TabBarCoordinator.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

class TabBarCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let catsNavigationController = UINavigationController()
        catsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let catsCoordinator = CastViewControllerCoordinator(navigationController: catsNavigationController)
        
        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        let favoritesCoordinator = FavoritesViewControllerCoordinator(navigationController: favoritesNavigationController)
        
        tabBarController.viewControllers = [catsNavigationController,
                                            favoritesNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        coordinate(to: catsCoordinator)
        coordinate(to: favoritesCoordinator)
    }

}
