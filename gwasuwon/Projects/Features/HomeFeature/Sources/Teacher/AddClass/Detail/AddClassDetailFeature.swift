//
//  AddClassDetailFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/13/24
//

import ComposableArchitecture
import Domain
import Foundation
import BaseFeature

@Reducer
public struct AddClassDetailFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
        @BindingState var isSubjectExpanded: Bool = false
        @BindingState var selectedSubject: SubjectType = .none
        var subjectList: [SubjectType] = [.math, .korean, .englsh]
        
        @BindingState var isClassTimeExpanded: Bool = false
        @BindingState var selectedClassTime: ClassTimeType = .none
        var classTimeList: [ClassTimeType] = [.one, .two, .three, .four, .five]
        
        var classDayList: [ClassProgressDay] = ClassDayType.allCases.map {
            ClassProgressDay(classDay: $0, isSelected: false)
        }
        @BindingState var classProgressCount: String = ""
        
        @BindingState var isClassStartDateExpanded: Bool = false
        var isSelectedClassStartDate: Bool = false
        @BindingState var selectedClassStartDate: Date = .now
    
        @BindingState var isClassDelayCountExpanded: Bool = false
        @BindingState var selectedClassDelayCount: ClassDelayCount = .none
        var classDelayCountList: [ClassDelayCount] = [.one, .two]
        
        @BindingState var addClassDetailAlertState: AlertFeature.State = .init()
        var addClassDetailAlertCase: AddClassDetailAlertCase = .none
        var isShowClassDelayInfo: Bool = false
        
        var isCreateClassButtonEnabled: Bool {
            selectedSubject != .none
            && selectedClassTime != .none
            && classDayList.filter { $0.isSelected }.count != 0
            && !classProgressCount.isEmpty
            && isSelectedClassStartDate
            && selectedClassDelayCount != .none
        }
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case navigateToBack
        case binding(BindingAction<State>)
        case selectSubject(String)
        case selectClassTime(String)
        case selectClassDay(Int)
        case setClassStartDayToggle
        case selectClassDelayCount(String)
        case showClassDelayInfo
        case addClassDetailAlertAction(AlertFeature.Action)
        case showAlert(AddClassDetailAlertCase)
        case createClassButtonTapped
    }

    public var body: some ReducerOf<AddClassDetailFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .navigateToBack:
                break
            case .binding(\.$selectedClassStartDate):
                if (!state.isSelectedClassStartDate) {
                    state.isSelectedClassStartDate = true
                }
                state.isClassStartDateExpanded = false
            case .binding:
                break
            case .addClassDetailAlertAction:
                break
            case let .showAlert(alertCase):
                state.addClassDetailAlertCase = alertCase
                return .send(.addClassDetailAlertAction(.present))
            case let .selectSubject(value):
                state.selectedSubject = SubjectType(rawValue: value) ?? .none
            case let .selectClassTime(value):
                state.selectedClassTime = ClassTimeType(rawValue: value) ?? .none
            case let .selectClassDay(index):
                state.classDayList[index].isSelected = !state.classDayList[index].isSelected
            case .setClassStartDayToggle:
                state.isClassStartDateExpanded.toggle()
            case let .selectClassDelayCount(value):
                state.selectedClassDelayCount = ClassDelayCount(rawValue: value) ?? .none
            case .showClassDelayInfo:
                return .send(.showAlert(.delayCountInfo))
            case .createClassButtonTapped:
                break
            }
            return .none
        }
        Scope(state: \.addClassDetailAlertState, action: \.addClassDetailAlertAction, child: {
            AlertFeature()
        })
    }
}

public struct ClassProgressDay: Hashable {
    public let classDay: ClassDayType
    public var isSelected: Bool
}

public enum AddClassDetailAlertCase {
    case none
    case delayCountInfo
}
