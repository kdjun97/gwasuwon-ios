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
        
    }

    public enum Action {
        case onAppear
        case navigateToBack
    }

    public var body: some ReducerOf<AddClassFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .navigateToBack:
                break
            }
            return .none
        }
    }
}
