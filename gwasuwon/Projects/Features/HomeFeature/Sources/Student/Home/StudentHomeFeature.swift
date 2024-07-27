//
//  StudentHomeFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import ComposableArchitecture
import Domain
import BaseFeature
import Foundation

@Reducer
public struct StudentHomeFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init() {}
        
        public enum AlertCase {
            case none
            case failure
            case attendanceFailure
        }
        
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
        
        var classDetail: ClassDetail? = nil
        var selectedDate: Date = .now
        
        var qrResult: String = ""
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case alertAction(AlertFeature.Action)
        case showAlert(State.AlertCase)
        case setClassDetail(ClassDetail)
        case setSelectedDate(Date)
        case qrScanButtonTapped(Bool)
        case setQRResult(String)
        case successAttendanceClass(String)
        case failureAttendanceClass
        case fetchDetailClassFailure(NetworkError)
    }

    public var body: some ReducerOf<StudentHomeFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .binding:
                break
            case .alertAction:
                break
            case let .showAlert(alertCase):
                state.alertCase = alertCase
                return .send(.alertAction(.present))
            case let .setClassDetail(classDetail):
                state.isLoading = false
                state.classDetail = classDetail
            case let .setSelectedDate(date):
                state.selectedDate = date
            case let .qrScanButtonTapped(isInvite):
                break
            case let .setQRResult(data):
                state.qrResult = data
                state.isLoading = true
                return .run { [classId = state.qrResult] send in
                    await send(attendanceClass(classId: classId))
                }
            case let .successAttendanceClass(classId):
                return .run { send in
                    await send(getDetailClass(classId: classId))
                }
            case .failureAttendanceClass:
                state.isLoading = false
                return .send(.showAlert(.attendanceFailure))
            case .fetchDetailClassFailure:
                state.isLoading = false
                return .send(.showAlert(.failure))
            }
            return .none
        }
    }
}

extension StudentHomeFeature {
    private func attendanceClass(classId: String) async -> Action {
        let response = await classUseCase.postAttendance("\(classId)")
        
        switch response {
        case .success:
            return .successAttendanceClass(classId)
        case .failure:
            return .failureAttendanceClass
        }
    }
    
    private func getDetailClass(classId: String) async -> Action {
        let response = await classUseCase.getDetailClass(classId)
        
        switch response {
        case let .success(classDetail):
            return .setClassDetail(classDetail)
        case let .failure(error):
            return .fetchDetailClassFailure(error)
        }
    }
}
