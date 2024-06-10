//
//  AccountUseCase.swift
//  Domain
//
//  Created by 김동준 on 6/7/24
//

import Dependencies
import DI

public struct AccountUseCase {
    public let getTestApi: () async -> Result<Bool, NetworkError>
}

extension AccountUseCase: DependencyKey {
    public static var liveValue: AccountUseCase = {
        let repository: AccountRepositoryProtocol = DIContainer.shared.resolve()
        return AccountUseCase(
            getTestApi: {
                await repository.getApiTest()
            }
        )
    }()
}

extension DependencyValues {
    public var accountUseCase: AccountUseCase {
        get { self[AccountUseCase.self] }
        set { self[AccountUseCase.self] = newValue }
    }
}
