//
//  LoginCoordinator.swift
//  Test
//
//  Created by 홍정민 on 11/14/24.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func didLoggedIn(_ coordinator: LoginCoordinator)
}

final class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var delegate: LoginCoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.delegate = self
        navigationController.viewControllers = [loginViewController]
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func login() {
        delegate?.didLoggedIn(self)
    }
}

