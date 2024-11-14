//
//  LoginViewController.swift
//  Test
//
//  Created by 홍정민 on 11/14/24.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    private let loginButton = UIButton()
    var coordinator: LoginCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        navigationItem.title = "로그인 화면"
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
        
        loginButton.backgroundColor = .green
        loginButton.setTitle("로그인", for: .normal)
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
}

extension LoginViewController {
    @objc
    private func loginButtonClicked() {
        coordinator?.login()
    }
}
