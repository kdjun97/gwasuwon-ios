//
//  EditClassView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import QRScanner
import BaseFeature

public struct EditClassView: View {
    let store: StoreOf<EditClassFeature>
    @ObservedObject var viewStore: ViewStoreOf<EditClassFeature>

    public init(store: StoreOf<EditClassFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        EditClassBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.alertState, action: \.alertAction)) {
            AlertView(viewStore: viewStore)
        }
    }
}

private struct EditClassBodyView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                GNavigationBar(
                    title: "수업 정보",
                    leadingIcon: GImage.icBack.swiftUIImage,
                    leadingIconAction: {
                        viewStore.send(.navigateToBack)
                    }
                )
                Spacer()
                Button {
                    viewStore.send(.editButtonTapped)
                } label: {
                    GText(
                        "수정",
                        fontStyle: .Label_2_B,
                        color: .primaryNormal
                    ).padding(.trailing, 8)
                }
            }.hPadding(16)
            GText(
                "계약 완료 이후, 학부모 님 동의없이 정보 수정이 불가능합니다.",
                fontStyle: .Caption_1_R,
                color: .labelNeutral
            )
            .greedyWidth(.leading)
            .hPadding(16)
            .padding(.bottom, 48)
            ClassInformationView(viewStore: viewStore)
            Spacer()
            if (!viewStore.isEditButtonVisible) {
                GButton(
                    title: "저장",
                    style: viewStore.isSaveButtonEnabled ? .enabled : .disabled,
                    buttonAction: { viewStore.send(.saveButtonTapped) }
                ).hPadding(16)
            }
        }
    }
}

private struct ClassInformationView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ClassDefaultInformation(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
                SelectSubjectView(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
                ClassProgressTimeView(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
                ClassProgressDaysView(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
                ClassProgressCountView(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
                ClassStartDayView(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
                ClassDelayCountView(viewStore: viewStore).disabled(viewStore.isEditButtonVisible)
            }.hPadding(16)
        }
    }
}

private struct ClassDefaultInformation: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        GTextField(
            label: "학생 이름",
            hintText: "ex) 김철수",
            text: viewStore.$studentName
        )
        GTextField(
            label: "학년",
            hintText: "ex) 고등학교 2학년",
            text: viewStore.$grade
        )
        GTextField(
            label: "한줄 메모",
            hintText: "ex) 확통 특히 어려워 함",
            text: viewStore.$memo
        )
    }
}

private struct SelectSubjectView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "과목",
                fontStyle: .Caption_1_B,
                color: .labelNormal
            )
            .greedyWidth(.leading)
            .padding([.leading, .bottom], 8)
            GDisclosureGroup(
                placeHolder: "과목 선택",
                isExpanded: viewStore.$isSubjectExpanded,
                selectedItem: viewStore.selectedSubject.name,
                items: viewStore.subjectList.map {$0.name},
                onClickAction: { value in
                    viewStore.send(.selectSubject(value))
                }
            )
        }
    }
}

private struct ClassProgressTimeView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "1회당 진행 시간",
                fontStyle: .Caption_1_B,
                color: .labelNormal
            )
            .padding([.leading, .bottom], 8)
            .greedyWidth(.leading)
            GDisclosureGroup(
                placeHolder: "진행 시간",
                isExpanded: viewStore.$isSessionDurationExpanded,
                selectedItem: viewStore.selectedSessionDurationType.convertISO8601TimeToString,
                items: viewStore.sessionDurationList.map {$0.convertISO8601TimeToString},
                onClickAction: { value in
                    viewStore.send(.selectSessionDuration(value))
                }
            )
        }
    }
}

private struct ClassProgressDaysView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "수업 진행 요일",
                fontStyle: .Caption_1_B,
                color: .labelNormal
            )
            .padding(.leading, 8)
            .padding(.bottom, 12)
            .greedyWidth(.leading)
            HStack(spacing: 0) {
                ForEach(Array(zip(viewStore.classDayList.indices, viewStore.classDayList)), id: \.0) { index, item in
                    Button {
                        viewStore.send(.selectClassDay(index))
                    } label: {
                        GText(
                            item.classDay.name,
                            fontStyle: .Body_1_Normal_B,
                            color: item.isSelected ? .staticWhite : .labelNormal
                        )
                        .hPadding(8)
                        .vPadding(4)
                    }
                    .background(item.isSelected ? Color.primaryStrong : Color.backgroundElevatedAlternative)
                    .cornerRadius(8)
                    if (index != viewStore.classDayList.count-1) {
                        Spacer()
                    }
                }
            }
            .greedyWidth()
        }
    }
}

private struct ClassProgressCountView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        GTextField(
            label: "진행 횟수",
            hintText: "ex) 8",
            text: viewStore.$numberOfSessions,
            keyboardType: .numberPad
        )
    }
}

private struct ClassStartDayView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "수업 시작일",
                fontStyle: .Caption_1_B,
                color: .labelNormal
            )
            .padding([.leading, .bottom], 8)
            .greedyWidth(.leading)
            
            VStack(spacing: 0) {
                Button {
                    viewStore.send(.setClassStartDayToggle)
                } label: {
                    HStack(spacing: 0) {
                        GText(
                            !viewStore.isSelectedClassStartDate
                            ? "2024-06-05"
                            : viewStore.selectedClassStartDate.formattedString(),
                            fontStyle: .Body_1_Normal_R,
                            color: !viewStore.isSelectedClassStartDate
                            ? .labelAssistive
                            : .labelNormal
                        )
                        Spacer()
                    }
                    .vPadding(12)
                    .hPadding(16)
                }
                
                if (viewStore.isClassStartDateExpanded) {
                    DatePicker(
                        "",
                        selection: viewStore.$selectedClassStartDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                }
            }
            .greedyWidth()
            .background(Color.backgroundElevatedNormal)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.lineRegularAlternative, lineWidth: 1.0)
            )
        }
    }
}

private struct ClassDelayCountView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 4) {
                GText(
                    "미루기 횟수",
                    fontStyle: .Caption_1_B,
                    color: .labelNormal
                ).padding(.leading, 8)
            }.padding(.bottom, 8)
            .greedyWidth(.leading)
            GDisclosureGroup(
                placeHolder: "미루기 횟수",
                isExpanded: viewStore.$isClassDelayCountExpanded,
                selectedItem: viewStore.selectedRescheduleCount.rawValue,
                items: viewStore.classDelayCountList.map {$0.name},
                onClickAction: { value in
                    viewStore.send(.selectClassDelayCount(value))
                }
            )
        }.padding(.bottom, 32)
    }
}

private struct AlertView: View {
    @ObservedObject private var viewStore: ViewStoreOf<EditClassFeature>

    fileprivate init(viewStore: ViewStoreOf<EditClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.alertCase {
        case .none: EmptyView()
        case .failure:
            GAlert(
                type: .includeIcon,
                title: "에러",
                contents: "알 수 없는 에러",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.alertAction(.dismiss))
                }
            )
        }
    }
}
