//
//  AddClassFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/12/24
//

import ComposableArchitecture
import Domain

@Reducer
public struct AddClassFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
        @BindingState var studentName: String = ""
        @BindingState var grade: String = ""
        @BindingState var memo: String = ""
        var isNextButtonEnabled: Bool {
            !(studentName.isEmpty) && !(grade.isEmpty) && !(memo.isEmpty)
        }
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case navigateToBack
        case binding(BindingAction<State>)
        case nextButtonTapped
        case navigateToAddClassDetail(String, String, String)
    }

    public var body: some ReducerOf<AddClassFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .navigateToBack:
                break
            case .binding:
                break
            case .nextButtonTapped:
                return .send(.navigateToAddClassDetail(state.studentName, state.grade, state.memo))
            case let .navigateToAddClassDetail(studentName, grade, memo):
                break
            }
            return .none
        }
    }
}
