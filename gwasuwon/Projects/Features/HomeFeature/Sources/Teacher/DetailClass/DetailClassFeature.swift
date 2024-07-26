//
//  DetailClassFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/14/24
//

import ComposableArchitecture
import BaseFeature
import Domain
import Foundation
import Util

@Reducer
public struct DetailClassFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init(id: Int) {
            classId = id
        }
        @BindingState var detailClassAlertState: AlertFeature.State = .init()
        var detailClassAlertCase: DetailClassAlertCase = .none
        @BindingState var isLoading = false
        
        var classId: Int
        var classDetail: ClassDetail? = nil
        
        var selectedDate: Date = .now
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case detailClassAlertAction(AlertFeature.Action)
        case showAlert(DetailClassAlertCase)
        case noAction
        case setClassDetail(ClassDetail)
        case navigateToBack
        case classMenuInformationButtonTapped
        case classMenuDeleteButtonTapped
        case alertDeleteButtonTapped
        case fetchClassDetailFailure(NetworkError)
        case inviteStudentButtonTapped
        case setSelectedDate(Date)
        case navigateToQRGeneration(Int)
        case navigateToClassEdit(Int)
    }

    public var body: some ReducerOf<DetailClassFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
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
            case let .setClassDetail(classDetail):
                state.isLoading = false
                state.classDetail = classDetail
                print("DONGJUN")
                print(state.classDetail.map{ $0.schedules.map { $0.date.toDateFromIntEpochMilliseconds().formattedString() } })
            case .navigateToBack:
                break
            case .classMenuInformationButtonTapped:
                return .send(.navigateToClassEdit(state.classId))
            case .classMenuDeleteButtonTapped:
                return .send(.showAlert(.delete))
            case .alertDeleteButtonTapped:
                // TODO: Implement class delete logic
                return .send(.detailClassAlertAction(.dismiss))
            case let .fetchClassDetailFailure(error):
                state.isLoading = false
                return .send(.showAlert(.fetchClassDetailFailure))
            case .inviteStudentButtonTapped:
                return .send(.navigateToQRGeneration(state.classId))
            case let .navigateToQRGeneration(Int):
                break
            case let .setSelectedDate(date):
                state.selectedDate = date
            case let .navigateToClassEdit(id):
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
    private func getDetailClass(classId: Int) async -> Action {
        let response = await classUseCase.getDetailClass("\(classId)")
        
        switch response {
        case let .success(classDetail):
            return .setClassDetail(classDetail)
        case let .failure(error):
            return .fetchClassDetailFailure(error)
        }
    }
}

public enum DetailClassAlertCase {
    case none
    case delete
    case fetchClassDetailFailure
}
