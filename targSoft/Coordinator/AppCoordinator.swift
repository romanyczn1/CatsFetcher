//
//  AppCoordinator.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarCoordinator = TabBarCoordinator(window: window)
        coordinate(to: tabBarCoordinator)
    }
}

