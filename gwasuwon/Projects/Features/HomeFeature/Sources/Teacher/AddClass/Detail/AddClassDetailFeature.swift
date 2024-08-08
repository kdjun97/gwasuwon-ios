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
    
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init(
            studentName: String,
            grade: String,
            memo: String
        ) {
            self.studentName = studentName
            self.grade = grade
            self.memo = memo
        }
        
        var studentName: String
        var grade: String
        var memo: String
        
        @BindingState var isLoading = false
        
        @BindingState var isSubjectExpanded: Bool = false
        @BindingState var selectedSubject: SubjectType = .none
        var subjectList: [SubjectType] = [.korean, .math, .english, .science, .social]
        
        @BindingState var isSessionDurationExpanded: Bool = false
        @BindingState var selectedSessionDurationType: SessionDurationType = .none
        var sessionDurationList: [SessionDurationType] = [.one, .oneHalf, .two, .twoHalf, .three]
        
        var classDayList: [ClassProgressDay] = ClassDayType.allCases.map {
            ClassProgressDay(classDay: $0, isSelected: false)
        }
        @BindingState var numberOfSessions: String = ""
        
        @BindingState var isClassStartDateExpanded: Bool = false
        var isSelectedClassStartDate: Bool = false
        @BindingState var selectedClassStartDate: Date = .now
    
        @BindingState var isClassDelayCountExpanded: Bool = false
        @BindingState var selectedRescheduleCount: RescheduleCountType = .none
        var classDelayCountList: [RescheduleCountType] = [.one, .two]
        
        @BindingState var addClassDetailAlertState: AlertFeature.State = .init()
        var addClassDetailAlertCase: AddClassDetailAlertCase = .none
        var isShowClassDelayInfo: Bool = false
        
        var isCreateClassButtonEnabled: Bool {
            selectedSubject != .none
            && selectedSessionDurationType != .none
            && classDayList.filter { $0.isSelected }.count != 0
            && !numberOfSessions.isEmpty
            && isSelectedClassStartDate
            && selectedRescheduleCount != .none
        }
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case navigateToBack
        case binding(BindingAction<State>)
        case selectSubject(String)
        case selectSessionDuration(String)
        case selectClassDay(Int)
        case setClassStartDayToggle
        case selectClassDelayCount(String)
        case showClassDelayInfo
        case addClassDetailAlertAction(AlertFeature.Action)
        case showAlert(AddClassDetailAlertCase)
        case createClassButtonTapped
        case navigateToAddClassDone(Int)
        case createClassSuccess(Int)
        case createClassFailure(NetworkError)
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
                state.selectedSubject = SubjectType.toSubjectType(code: value)
            case let .selectSessionDuration(value):
                state.selectedSessionDurationType = SessionDurationType.toSessionDurationType(code: value)
            case let .selectClassDay(index):
                state.classDayList[index].isSelected = !state.classDayList[index].isSelected
            case .setClassStartDayToggle:
                state.isClassStartDateExpanded.toggle()
            case let .selectClassDelayCount(value):
                state.selectedRescheduleCount = RescheduleCountType(rawValue: value) ?? .none
            case .showClassDelayInfo:
                return .send(.showAlert(.delayCountInfo))
            case .createClassButtonTapped:
                state.isLoading = true
                return .run { [
                    studentName = state.studentName,
                    grade = state.grade,
                    memo = state.memo,
                    subject = state.selectedSubject,
                    sessionDuration = state.selectedSessionDurationType,
                    classDays = state.classDayList.filter{ $0.isSelected }.map{ $0.classDay.rawValue },
                    numberOfSessions = Int(state.numberOfSessions) ?? 0,
                    startDate = state.selectedClassStartDate.toEpochMilliseconds(),
                    rescheduleCount = Int(state.selectedRescheduleCount.rawValue) ?? 0
                ] send in
                    await send(createClass(studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount))
                }
            case let .navigateToAddClassDone(id):
                break
            case let .createClassSuccess(id):
                state.isLoading = false
                return .send(.navigateToAddClassDone(id))
            case let .createClassFailure(error):
                state.isLoading = false
                return .send(.showAlert(.createClassFailure))
            }
            return .none
        }
        Scope(state: \.addClassDetailAlertState, action: \.addClassDetailAlertAction, child: {
            AlertFeature()
        })
    }
}

public enum AddClassDetailAlertCase {
    case none
    case delayCountInfo
    case createClassFailure
}

extension AddClassDetailFeature {
    private func createClass(
        _ studentName: String,
        _ grade: String,
        _ memo: String,
        _ subject: SubjectType,
        _ sessionDuration: SessionDurationType,
        _ classDays: [String],
        _ numberOfSessions: Int,
        _ startDate: Int,
        _ rescheduleCount: Int
    ) async -> Action {
        let response = await classUseCase.postCreateClass(studentName, grade, memo, subject, sessionDuration, classDays, numberOfSessions, startDate, rescheduleCount)
        switch response {
        case let .success(id):
            return .createClassSuccess(id)
        case let .failure(error):
            return .createClassFailure(error)
        }
    }
}
