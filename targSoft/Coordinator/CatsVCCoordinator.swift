//
//  CatsVCCoordinator.swift
//  targSoft
//
//  Created by Roman Bukh on 7.08.21.
//

import UIKit

class CastViewControllerCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let catsViewController = CatsViewController()
        navigationController.pushViewController(catsViewController, animated: true)
    }
}
