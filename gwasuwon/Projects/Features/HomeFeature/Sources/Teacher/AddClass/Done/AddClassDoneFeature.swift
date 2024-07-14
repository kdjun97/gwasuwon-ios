//
//  AddClassDoneFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/14/24
//

import ComposableArchitecture
import UIKit
import BaseFeature

@Reducer
public struct AddClassDoneFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
        @BindingState var addClassDoneAlertState: AlertFeature.State = .init()
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case addClassDoneAlertAction(AlertFeature.Action)
        case sendContractButtonTapped
        case showClassInfoButtonTapped
        case showAlert
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
                UIPasteboard.general.string = "복사된 텍스트"
                return .send(.showAlert)
            case .showClassInfoButtonTapped:
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
