//
//  AddClassDetailView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/13/24
//

import ComposableArchitecture
import DesignSystem
import SwiftUI
import BaseFeature
import Util

public struct AddClassDetailView: View {
    let store: StoreOf<AddClassDetailFeature>
    @ObservedObject var viewStore: ViewStoreOf<AddClassDetailFeature>

    public init(store: StoreOf<AddClassDetailFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        AddClassDetailBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gAlert(self.store.scope(state: \.addClassDetailAlertState, action: \.addClassDetailAlertAction)) {
            GAlert(
                type: .onlyContents,
                title: "미루기 횟수",
                contents: "수업을 미룰 수 있는 횟수를 설정할 수 있습니다. 출석 미체크 시 횟수가 1회 차감되며 횟수가 0이 되면 수업이 연장되지 않고 종료됩니다.",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.addClassDetailAlertAction(.dismiss))
                }
            )
        }
    }
}

private struct AddClassDetailBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GNavigationBar(
                title: "수업 추가하기",
                leadingIcon: GImage.icBack.swiftUIImage,
                leadingIconAction: {
                    viewStore.send(.navigateToBack)
                }
            ).hPadding(16)
            ScrollView {
                AdditionalInformationView(viewStore: viewStore).padding(.bottom, 36).hPadding(16)
                ClassScheduleView(viewStore: viewStore).hPadding(16)
            }
            Spacer()
            GButton(
                title: "수업 생성",
                style: viewStore.isCreateClassButtonEnabled ? .enabled : .disabled,
                buttonAction: {
                    viewStore.send(.createClassButtonTapped)
                }
            ).hPadding(16)
        }
    }
}

private struct AdditionalInformationView: View {
    @ObservedObject private var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "추가 정보",
                fontStyle: .Headline_1_B,
                color: .labelNormal
            )
            .greedyWidth(.leading)
            .vPadding(24)
            GDisclosureGroup(
                placeHolder: "과목 선택",
                isExpanded: viewStore.$isSubjectExpanded,
                selectedItem: viewStore.selectedSubject.rawValue,
                items: viewStore.subjectList.map {$0.rawValue},
                onClickAction: { value in
                    viewStore.send(.selectSubject(value))
                }
            )
        }
    }
}

private struct ClassScheduleView: View {
    @ObservedObject private var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "수업 일정",
                fontStyle: .Headline_1_B,
                color: .labelNormal
            )
            .greedyWidth(.leading)
            .padding(.bottom, 24)
            ClassTimeView(viewStore: viewStore)
            ClassProgressDaysView(viewStore: viewStore).padding(.bottom, 24)
            GTextField(
                label: "진행 횟수",
                hintText: "ex) 8",
                text: viewStore.$classProgressCount,
                keyboardType: .numberPad
            ).padding(.bottom, 24)
            ClassStartDayView(viewStore: viewStore)
            ClassDelayCountView(viewStore: viewStore)
        }
    }
}

private struct ClassTimeView: View {
    @ObservedObject private var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        GText(
            "1회당 진행 시간",
            fontStyle: .Caption_1_B,
            color: .labelNormal
        )
        .padding([.leading, .bottom], 8)
        .greedyWidth(.leading)
        GDisclosureGroup(
            placeHolder: "진행 시간",
            isExpanded: viewStore.$isClassTimeExpanded,
            selectedItem: viewStore.selectedClassTime.rawValue,
            items: viewStore.classTimeList.map {$0.rawValue},
            onClickAction: { value in
                viewStore.send(.selectClassTime(value))
            }
        )
        .padding(.bottom, 24)
    }
}

private struct ClassProgressDaysView: View {
    @ObservedObject private var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
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
                            item.classDay.rawValue,
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

private struct ClassStartDayView: View {
    @ObservedObject private var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
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
        }.padding(.bottom, 24)
    }
}

private struct ClassDelayCountView: View {
    @ObservedObject private var viewStore: ViewStoreOf<AddClassDetailFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDetailFeature>) {
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
                Button {
                    viewStore.send(.showClassDelayInfo)
                } label: {
                    GImage.icInfo.swiftUIImage
                }
            }.padding(.bottom, 8)
            .greedyWidth(.leading)
            GDisclosureGroup(
                placeHolder: "미루기 횟수",
                isExpanded: viewStore.$isClassDelayCountExpanded,
                selectedItem: viewStore.selectedClassDelayCount.rawValue,
                items: viewStore.classDelayCountList.map {$0.rawValue},
                onClickAction: { value in
                    viewStore.send(.selectClassDelayCount(value))
                }
            )
        }.padding(.bottom, 32)
    }
}
