//
//  RootScreen.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import ComposableArchitecture
import SignInFeature
import SignUpFeature

@Reducer
public struct RootScreen {
    public enum State: Equatable {
        case signIn(SignInFeature.State)
        case signUp(SignUpFeature.State)
    }

    public enum Action {
        case signIn(SignInFeature.Action)
        case signUp(SignUpFeature.Action)
    }

    public init() {}
    public var body: some ReducerOf<RootScreen> {
        Scope(state: \.signIn, action: \.signIn) {
            SignInFeature()
        }
        Scope(state: \.signUp, action: \.signUp) {
            SignUpFeature()
        }
    }
}
