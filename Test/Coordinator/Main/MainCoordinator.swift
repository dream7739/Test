//
//  MainCoordinator.swift
//  Test
//
//  Created by 홍정민 on 11/14/24.
//

import UIKit

final class MainCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController()
        navigationController.viewControllers = [mainViewController]
    }
}
