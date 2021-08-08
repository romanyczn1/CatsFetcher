//
//  TabBarCoordinator.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

class TabBarCoordinator: Coordinator {
    weak var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
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
        
        window!.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        coordinate(to: catsCoordinator)
        coordinate(to: favoritesCoordinator)
    }

}
