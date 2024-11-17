//
//  UserDefaultsManager.swift
//  Test
//
//  Created by 홍정민 on 11/17/24.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let storage = UserDefaults.standard
    let key: String
    let defaultValue: T
    var wrappedValue: T {
        get {
            return storage.object(forKey: key) as? T ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
}

enum UserDefaultsKey: String {
    case userId
    case accessToken
}

protocol User {
    var userId: String { get set }
    var accessToken: String { get set }
}

class UserInfo: User {
    static let shared = UserInfo()
    
    @UserDefault(key: UserDefaultsKey.userId.rawValue, defaultValue: "")
    var userId: String
    
    @UserDefault(key: UserDefaultsKey.accessToken.rawValue, defaultValue: "")
    var accessToken: String
    
    private init() { }
}
