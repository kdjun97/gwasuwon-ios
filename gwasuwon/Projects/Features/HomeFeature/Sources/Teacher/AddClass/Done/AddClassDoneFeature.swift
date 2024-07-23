//
//  AddClassDoneFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/14/24
//

import ComposableArchitecture
import BaseFeature

@Reducer
public struct AddClassDoneFeature {
    public init() {}

    public struct State: Equatable {
        public init(id: Int) {
            self.id = id
        }
        @BindingState var addClassDoneAlertState: AlertFeature.State = .init()
        var id: Int
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case addClassDoneAlertAction(AlertFeature.Action)
        case sendContractButtonTapped
        case showClassInfoButtonTapped
        case showAlert
        case navigateToDetailClass(Int)
    }

    public var body: some ReducerOf<AddClassDoneFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .binding:
                break
            case .addClassDoneAlertAction:
                break
            case .sendContractButtonTapped:
                return .send(.showAlert)
            case .showClassInfoButtonTapped:
                return .send(.navigateToDetailClass(state.id))
            case let .navigateToDetailClass(id):
                break
            case .showAlert:
                return .send(.addClassDoneAlertAction(.present))
            }
            return .none
        }
        Scope(state: \.addClassDoneAlertState, action: \.addClassDoneAlertAction, child: {
            AlertFeature()
        })
    }
}
