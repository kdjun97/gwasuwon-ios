//
//  RootScreen.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import ComposableArchitecture
import SignInFeature
import SignUpFeature
import HomeFeature

@Reducer
public struct RootScreen {
    public enum State: Equatable {
        case signIn(SignInFeature.State)
        case signUp(SignUpFeature.State)
        case home(HomeFeature.State)
        case signUpRole(SignUpRoleFeature.State)
    }

    public enum Action {
        case signIn(SignInFeature.Action)
        case signUp(SignUpFeature.Action)
        case home(HomeFeature.Action)
        case signUpRole(SignUpRoleFeature.Action)
    }

    public init() {}
    public var body: some ReducerOf<RootScreen> {
        Scope(state: \.signIn, action: \.signIn) {
            SignInFeature()
        }
        Scope(state: \.signUp, action: \.signUp) {
            SignUpFeature()
        }
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Scope(state: \.signUpRole, action: \.signUpRole) {
            SignUpRoleFeature()
        }
    }
}
