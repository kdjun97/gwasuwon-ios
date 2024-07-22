//
//  TeacherFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/11/24
//

import ComposableArchitecture
import Domain
import BaseFeature

@Reducer
public struct TeacherFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init() {}
        
        enum AlertCase {
            case none
            case failure
        }
        
        var role: AuthRole = AuthRole(rawValue: UserManager.shared.role) ?? .teacher
        var classInformation: ClassInformation? = nil
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case alertAction(AlertFeature.Action)
        case onAppear
        case addClassButtonTapped
        case noAction
        case setClassInformation(ClassInformation)
        case navigateToClassDetail(Int)
    }

    public var body: some ReducerOf<TeacherFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    await send(getClassList())
                }
            case .binding:
                break
            case .addClassButtonTapped:
                break
            case .noAction:
                state.isLoading = false
                break
            case let .setClassInformation(classInformation):
                state.isLoading = false
                print("dONGJUN -> classInformation \(classInformation)")
                state.classInformation = classInformation
            case let .navigateToClassDetail(id):
                break
            case .alertAction:
                break
            }
            return .none
        }
        Scope(state: \.alertState, action: \.alertAction, child: {
            AlertFeature()
        })
    }
}

extension TeacherFeature {
    private func getClassList() async -> Action {
        let response = await classUseCase.getClassList()
        
        switch response {
        case let .success(classInformationList):
            return .setClassInformation(classInformationList)
        case .failure:
            return .noAction
        }
    }
}
