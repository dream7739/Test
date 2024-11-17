//
//  KeychainViewController.swift
//  Test
//
//  Created by 홍정민 on 11/17/24.
//

import UIKit

final class KeychainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUserDefaults()
    }
    
    private func configureUserDefaults() {
        UserInfo.shared.userId = "뽀로로"
        UserInfo.shared.accessToken = "루피"
        print(UserInfo.shared.userId)
        print(UserInfo.shared.accessToken)
    }
}
