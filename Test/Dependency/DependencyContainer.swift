//
//  DependencyContainer.swift
//  Test
//
//  Created by 홍정민 on 11/12/24.
//

import Foundation

final class DependencyContainer {
    private static var shared = DependencyContainer()
    private init() { }
    
    private var dependencies: [String: Any] = [:]
    
    static func register<T>(_ dependency: T) {
        shared.register(dependency)
    }
    
    static func resolve<T>() -> T {
        shared.resolve()
    }
    
    // 등록
    private func register<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency
    }
    
    // 반환
    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T
        precondition(dependency != nil, "\(key) Dependency Not Found")
        return dependency!
    }
    
}
