//
//  ClassUseCase.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

import Dependencies
import DI

public struct ClassUseCase {
    public let getClassList: () async -> Result<[ClassInformation], NetworkError>
}

extension ClassUseCase: DependencyKey {
    public static var liveValue: ClassUseCase = {
        let repository: ClassRepositoryProtocol = DIContainer.shared.resolve()
        return ClassUseCase(
            getClassList: {
                // await repository.getClassList() -> API Call 아직 미구현
                return .success(DummyClass.classList)
            }
        )
    }()
}

extension DependencyValues {
    public var classUseCase: ClassUseCase {
        get { self[ClassUseCase.self] }
        set { self[ClassUseCase.self] = newValue }
    }
}
