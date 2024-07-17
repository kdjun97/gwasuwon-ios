//
//  StudentFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/17/24
//

import ComposableArchitecture
import Domain

@Reducer
public struct StudentFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case onAppear
    }

    public var body: some ReducerOf<StudentFeature> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            }
            return .none
        }
    }
}
