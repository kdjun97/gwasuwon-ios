//
//  TeacherFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/11/24
//

import ComposableArchitecture
import Domain

@Reducer
public struct TeacherFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init() {}
        
        var role: AuthRole = .teacher
        var classInformationList: [ClassInformation] = [] // TODO: type 수업 모델로 변경
    }

    public enum Action {
        case onAppear
        case addClassButtonTapped
        case noAction
        case setClassInformation([ClassInformation])
    }

    public var body: some ReducerOf<TeacherFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                // TODO: Loading 처리
                return .run { send in
                    await send(getClassList())
                }
            case .addClassButtonTapped:
                break
            case .noAction:
                break
            case let .setClassInformation(classInformationList):
                state.classInformationList = classInformationList
            }
            return .none
        }
    }
}

extension TeacherFeature {
    private func getClassList() async -> Action {
        let response = await classUseCase.getClassList()
        
        switch response {
        case let .success(classInformationList):
            return .setClassInformation(classInformationList)
        case let .failure(networkError):
            return .noAction
        }
    }
}
