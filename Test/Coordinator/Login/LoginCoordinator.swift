//
//  LoginCoordinator.swift
//  Test
//
//  Created by 홍정민 on 11/14/24.
//

import UIKit

final class LoginCoordinator: Coordinator {
    var parentCoordinator: AppCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        navigationController.viewControllers = [loginViewController]
    }
    
    func login() {
        parentCoordinator?.showMainViewController()
        parentCoordinator?.childDidFinish(self)
    }
}
