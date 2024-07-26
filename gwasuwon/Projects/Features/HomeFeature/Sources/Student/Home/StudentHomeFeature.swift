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

    public struct State: Equatable {
        public init() {}
        
        public enum AlertCase {
            case none
            case failure
        }
        
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
        
        var classDetail: ClassDetail? = nil
        var selectedDate: Date = .now
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case alertAction(AlertFeature.Action)
        case showAlert(State.AlertCase)
        case setClassDetail(ClassDetail)
        case setSelectedDate(Date)
        case qrScanButtonTapped
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
                state.classDetail = classDetail
            case let .setSelectedDate(date):
                state.selectedDate = date
            case .qrScanButtonTapped:
                break
            }
            return .none
        }
    }
}
