//
//  StudentFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/17/24
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
        
        var isCameraPermissionGranted: Bool = false
        var qrResult: String = ""
        var isInviteDone: Bool = false
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
        var classId: Int = 0
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case alertAction(AlertFeature.Action)
        case showAlert(State.AlertCase)
        case qrScanButtonTapped
        case setCameraPermissionIsGranted(Bool)
        case setQRResult(String)
        case inviteClassDone
        case navigateToStudentDetail(Int)
        case successJoinClass(Int)
        case failureJoinClass(NetworkError)
        case moveToCalendarButtonTapped
    }

    public var body: some ReducerOf<StudentFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .qrScanButtonTapped:
                break
            case .alertAction:
                break
            case let .showAlert(alertCase):
                state.alertCase = alertCase
                return .send(.alertAction(.present))
            case .binding:
                break
            case let .setCameraPermissionIsGranted(value):
                state.isCameraPermissionGranted = value
            case let .setQRResult(data):
                state.qrResult = data
                state.isLoading = true
                return .run { [classId = state.qrResult] send in
                    await send(joinClass(classId: classId))
                }
            case .inviteClassDone:
                state.isInviteDone = true
            case .moveToCalendarButtonTapped:
                return .send(.navigateToStudentDetail(state.classId))
            case let .navigateToStudentDetail(id):
                break
            case let .successJoinClass(id):
                state.isLoading = false
                state.classId = id
                return .send(.inviteClassDone)
            case let .failureJoinClass(error):
                state.isLoading = false
                state.alertCase = .failure
                return .send(.alertAction(.present))
            }
            return .none
        }
        Scope(state: \.alertState, action: \.alertAction, child: {
            AlertFeature()
        })
    }
}

extension StudentFeature {
    private func joinClass(classId: String) async -> Action {
        let response = await classUseCase.postJoinClass("\(classId)")
        
        switch response {
        case let .success(id):
            return .successJoinClass(id)
        case let .failure(error):
            return .failureJoinClass(error)
        }
    }
}
