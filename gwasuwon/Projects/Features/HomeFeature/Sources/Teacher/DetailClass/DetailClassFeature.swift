//
//  DetailClassFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/14/24
//

import ComposableArchitecture
import BaseFeature
import Domain

@Reducer
public struct DetailClassFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init(id: String) {
            classId = id
        }
        @BindingState var detailClassAlertState: AlertFeature.State = .init()
        var detailClassAlertCase: DetailClassAlertCase = .none
        
        var classId: String
        var classInformation: ClassInformation? = nil
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case detailClassAlertAction(AlertFeature.Action)
        case showAlert(DetailClassAlertCase)
        case noAction
        case setClassInformation(ClassInformation)
        case navigateToBack
        case classMenuInformationButtonTapped
        case classMenuDeleteButtonTapped
        case alertDeleteButtonTapped
    }

    public var body: some ReducerOf<DetailClassFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { [classId = state.classId] send in
                    await send(getDetailClass(classId: classId))
                }
            case .binding:
                break
            case .detailClassAlertAction:
                break
            case let .showAlert(alertCase):
                state.detailClassAlertCase = alertCase
                return .send(.detailClassAlertAction(.present))
            case .noAction:
                break
            case let .setClassInformation(classInformation):
                state.classInformation = classInformation
            case .navigateToBack:
                break
            case .classMenuInformationButtonTapped:
                break
            case .classMenuDeleteButtonTapped:
                break
            case .alertDeleteButtonTapped:
                break
            }
            return .none
        }
        Scope(state: \.detailClassAlertState, action: \.detailClassAlertAction, child: {
            AlertFeature()
        })
    }
}

extension DetailClassFeature {
    private func getDetailClass(classId: String) async -> Action {
        let response = await classUseCase.getDetailClass(classId)
        
        switch response {
        case let .success(classInformation):
            return .setClassInformation(classInformation)
        case .failure:
            return .noAction
        }
    }
}

public enum DetailClassAlertCase {
    case none
    case delete
}
