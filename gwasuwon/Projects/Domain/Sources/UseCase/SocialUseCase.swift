//
//  SocialUseCase.swift
//  Domain
//
//  Created by 김동준 on 7/19/24
//

import Dependencies
import DI

public struct SocialUseCase {
    public let signInWithKakao: () async -> Result<String, NetworkError>
}

extension SocialUseCase: DependencyKey {
    public static var liveValue: SocialUseCase = {
        let repository: SocialRepositoryProtocol = DIContainer.shared.resolve()
        return SocialUseCase(
            signInWithKakao: {
                await repository.signInWithKakao()
            }
        )
    }()
}

extension DependencyValues {
    public var socialUseCase: SocialUseCase {
        get { self[SocialUseCase.self] }
        set { self[SocialUseCase.self] = newValue }
    }
}
