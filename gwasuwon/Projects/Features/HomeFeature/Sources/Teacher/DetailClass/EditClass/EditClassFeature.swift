//
//  EditClassFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import ComposableArchitecture
import Domain
import BaseFeature
import Foundation

@Reducer
public struct EditClassFeature {
    public init() {}
    @Dependency(\.classUseCase) var classUseCase

    public struct State: Equatable {
        public init(classId: Int) {
            self.classId = classId
        }
        
        public enum AlertCase {
            case none
            case failure
        }
        
        var classId: Int
        
        @BindingState var isLoading = false
        @BindingState var alertState: AlertFeature.State = .init()
        var alertCase: AlertCase = .none
        
        @BindingState var studentName: String = ""
        @BindingState var grade: String = ""
        @BindingState var memo: String = ""
        
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
        
        var isSaveButtonEnabled: Bool {
            !(studentName.isEmpty) 
            && !(grade.isEmpty)
            && !(memo.isEmpty) 
            && selectedSubject != .none
            && selectedSessionDurationType != .none
            && classDayList.filter { $0.isSelected }.count != 0
            && !numberOfSessions.isEmpty
            && isSelectedClassStartDate
            && selectedRescheduleCount != .none
        }
        
        var isEditButtonVisible: Bool = true
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case navigateToBack
        case binding(BindingAction<State>)
        case saveButtonTapped
        case alertAction(AlertFeature.Action)
        case selectSubject(String)
        case selectSessionDuration(String)
        case selectClassDay(Int)
        case setClassStartDayToggle
        case selectClassDelayCount(String)
        case setClassInformation(ClassDetail)
        case fetchClassDetailFailure(NetworkError)
        case showAlert(State.AlertCase)
        case editButtonTapped
    }

    public var body: some ReducerOf<EditClassFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
                return .run { [classId = state.classId] send in
                    await send(getDetailClass(classId: classId))
                }
            case let .setClassInformation(classDetail):
                state.isLoading = false
                state.studentName = classDetail.studentName
                state.grade = classDetail.grade
                state.memo = classDetail.memo
                state.selectedSubject = classDetail.subject
                state.selectedSessionDurationType = classDetail.sessionDuration
                state.classDayList = state.classDayList.map {
                    if (classDetail.classDays.contains($0.classDay)) {
                        ClassProgressDay(classDay: $0.classDay, isSelected: true)
                    } else {
                        $0
                    }
                }
                state.numberOfSessions = String(classDetail.numberOfSessions)
                state.selectedClassStartDate = Int(classDetail.startDate).toDateFromIntEpochMilliseconds()
                state.isSelectedClassStartDate = true
                print("DONG -> \(Int(classDetail.startDate).toDateFromIntEpochMilliseconds())")
                state.selectedRescheduleCount = classDetail.rescheduleCount
                
            case let .fetchClassDetailFailure(error):
                return .send(.showAlert(.failure))
            case let .showAlert(alertCase):
                state.isLoading = false
                state.alertCase = alertCase
                return .send(.alertAction(.present))
            case .alertAction:
                break
            case .navigateToBack:
                break
            case .binding(\.$selectedClassStartDate):
                print("DONGJUN -> \(state.selectedClassStartDate)")
                if (!state.isSelectedClassStartDate) {
                    state.isSelectedClassStartDate = true
                }
                state.isClassStartDateExpanded = false
            case .binding:
                break
            case let .selectSubject(value):
                state.selectedSubject = SubjectType.toSubjectType(code: value)
            case let .selectSessionDuration(value):
                state.selectedSessionDurationType = SessionDurationType.toSessionDurationType(code: value)
            case let .selectClassDay(index):
                state.classDayList[index].isSelected = !state.classDayList[index].isSelected
            case .setClassStartDayToggle:
                state.isClassStartDateExpanded.toggle()
            case let .selectClassDelayCount(value):
                state.selectedRescheduleCount = RescheduleCountType.toRescheduleCountType(code: value)
            case .saveButtonTapped:
                break
            case .editButtonTapped:
                state.isEditButtonVisible = false
            }
            return .none
        }
        Scope(state: \.alertState, action: \.alertAction, child: {
            AlertFeature()
        })
    }
}

extension EditClassFeature {
    private func getDetailClass(classId: Int) async -> Action {
        let response = await classUseCase.getDetailClass("\(classId)")
        
        switch response {
        case let .success(classDetail):
            return .setClassInformation(classDetail)
        case let .failure(error):
            return .fetchClassDetailFailure(error)
        }
    }
}
