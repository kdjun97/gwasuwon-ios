//
//  StudentHomeFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import ComposableArchitecture
import Domain
import BaseFeature

@Reducer
public struct StudentFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init() {}
        
        public enum AlertCase {
            case none
            case failure
        }
        
        public enum ClassVisibleType {
            case none
            case hasSchedule
            case noSchedule
        }
        
        public var studentNoScheduleState = StudentNoScheduleFeature.State()
        public var studentHomeState = StudentHomeFeature.State()
        
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
        var classId: Int = 0
        var classDetail: ClassDetail? = nil
        var classVisibleType: ClassVisibleType = .none
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case alertAction(AlertFeature.Action)
        case showAlert(State.AlertCase)
        case onAppear
        case setClassDetail(ClassDetail)
        case studentNoScheduleAction(StudentNoScheduleFeature.Action)
        case studentHomeAction(StudentHomeFeature.Action)
        case fetchClassDetailFailure(NetworkError)
    }

    public var body: some ReducerOf<StudentFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .studentNoScheduleAction:
                break
            case .studentHomeAction:
                break
            case .alertAction:
                break
            case let .showAlert(alertCase):
                state.alertCase = alertCase
                return .send(.alertAction(.present))
            case .binding:
                break
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    await send(getDetailClass())
                }
            case let .setClassDetail(classDetail):
                state.isLoading = false
                state.classDetail = classDetail
                state.classVisibleType = .hasSchedule
            case let .fetchClassDetailFailure(error):
                state.isLoading = false
                state.classVisibleType = .noSchedule
                return .send(.showAlert(.failure))
            }
            return .none
        }
        Scope(state: \.alertState, action: \.alertAction, child: {
            AlertFeature()
        })
        Scope(state: \.studentNoScheduleState, action: \.studentNoScheduleAction, child: {
            StudentNoScheduleFeature()
        })
        Scope(state: \.studentHomeState, action: \.studentHomeAction, child: {
            StudentHomeFeature()
        })
    }
}

extension StudentFeature {
    private func getDetailClass() async -> Action {
        let response = await classUseCase.getDetailClassForStudent()
        
        switch response {
        case let .success(classDetail):
            return .setClassDetail(classDetail)
        case let .failure(error):
            return .fetchClassDetailFailure(error)
        }
    }
}
