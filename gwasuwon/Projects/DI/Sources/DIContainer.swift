//
//  DIContainer.swift
//  DITests
//
//  Created by 김동준 on 6/6/24
//

import Swinject

public struct DIContainer {
    public let container: Container
    public static let shared = DIContainer()
    
    private init() {
        self.container = Container()
    }
    
    public func resolve<T>() -> T {
        container.resolve()
    }
}

public extension Resolver {
    func resolve<T>() -> T {
        guard let implements = resolve(T.self) else {
            fatalError("cannot resolve \(String(describing: T.self))")
        }
        return implements
    }
}
