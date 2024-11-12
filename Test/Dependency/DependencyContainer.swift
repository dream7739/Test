//
//  DependencyContainer.swift
//  Test
//
//  Created by 홍정민 on 11/12/24.
//

import Foundation

@propertyWrapper
class Dependency<T: AnyObject> {
    let wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyContainer.resolve()
    }
}

struct Weak {
    weak var value: AnyObject?
    
    init(value: AnyObject) {
        self.value = value
    }
}

final class DependencyContainer {
    private static var shared = DependencyContainer()
    private init() { }
    
    private var dependency: [AnyObject] = []
    private var dependencies: [String: Weak] = [:]
    
    static func register<T: AnyObject>(_ dependency: T) {
        shared.register(dependency)
    }
    
    static func resolve<T: AnyObject>() -> T {
        shared.resolve()
    }
    
    private func register<T: AnyObject>(_ dependency: T) {
        let key = String(describing: T.self)
        self.dependency.append(dependency)
        dependencies[key] = Weak(value: dependency)
    }
    
    private func resolve<T: AnyObject>() -> T {
        let key = String(describing: T.self)
        let container = dependencies[key]
        let dependency = container?.value as? T
        precondition(dependency != nil, "\(key) Dependency Not Found")
        return dependency!
    }
    
}
