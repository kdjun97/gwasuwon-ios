//
//  ClassUseCase.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

import Dependencies
import DI

public struct ClassUseCase {
    public let getClassList: () async -> Result<ClassInformation, NetworkError>
    public let getDetailClass: (_ id: String) async -> Result<ClassInformation, NetworkError>
}

extension ClassUseCase: DependencyKey {
    public static var liveValue: ClassUseCase = {
        let repository: ClassRepositoryProtocol = DIContainer.shared.resolve()
        return ClassUseCase(
            getClassList: {
                 await repository.getClassList()
            },
            getDetailClass: { id in
                // await repository.getDetailClass() -> API Call 아직 미구현
                return .success(DummyClass.detailClass)
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
