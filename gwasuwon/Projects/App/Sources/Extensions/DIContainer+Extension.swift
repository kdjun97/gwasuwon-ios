//
//  DIContainer+Extension.swift
//  App
//
//  Created by 김동준 on 6/6/24
//

import DI
import Domain
import Data

extension DIContainer {
    func register() {
        container.register(ApiService.self) { _ in
            ApiService()
        }
        
        container.register(AccountRepositoryProtocol.self) { resolver in
            let apiService: ApiService = resolver.resolve()
            return AccountRepository(apiService: apiService)
        }
        
        container.register(ClassRepositoryProtocol.self) { resolver in
            let apiService: ApiService = resolver.resolve()
            return ClassRepository(apiService: apiService)
        }
        
        container.register(SocialRepositoryProtocol.self) { resolver in
            let apiService: ApiService = resolver.resolve()
            return SocialRepository(apiService: apiService)
        }
    }
}
