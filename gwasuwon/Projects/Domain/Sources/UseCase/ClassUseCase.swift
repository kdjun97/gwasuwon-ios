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
    public let postCreateClass: (
        _ studentName: String,
        _ grade: String,
        _ memo: String,
        _ subject: SubjectType,
        _ sessionDuration: SessionDurationType,
        _ classDays: [String],
        _ numberOfSessions: Int,
        _ startDate: Int,
        _ rescheduleCount: Int
    ) async -> Result<Int, NetworkError>
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
            }, 
            postCreateClass: { studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount in
                await repository.postCreateClass(studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount)
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
