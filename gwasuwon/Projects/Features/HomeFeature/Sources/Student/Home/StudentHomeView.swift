//
//  StudentHomeView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import BaseFeature
import Util

struct StudentHomeView: View {
    let store: StoreOf<StudentHomeFeature>
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>

    public init(store: StoreOf<StudentHomeFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        StudentHomeBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.alertState, action: \.alertAction)) {
            AlertView(viewStore: viewStore)
        }
    }
}

private struct StudentHomeBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>

    fileprivate init(viewStore: ViewStoreOf<StudentHomeFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            StudentHomeNavigationBar().hPadding(16)
            ScrollView {
                GCalendar(viewStore: viewStore).padding(.bottom, 16).hPadding(16)
                CalendarLabelView().padding(.bottom, 24).hPadding(16)
                CalendarInfoView(viewStore: viewStore).hPadding(16)
            }
            Spacer()
            QRScanButton(viewStore: viewStore)
        }
    }
}

private struct StudentHomeNavigationBar: View {
    fileprivate var body: some View {
        HStack(spacing: 0) {
            GNavigationBar(
                title: "수업 일정"
            )
            Spacer()
        }.padding(.bottom, 16)
    }
}

private struct GCalendar: View {
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentHomeFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        if let classDetail = viewStore.classDetail {
            VStack {
                GCalenderView(schedules: classDetail.schedules.map { GCalendarSchedule(id: $0.id, date: $0.date, status: GCalendarScheduleStatus(rawValue: $0.status.rawValue) ?? .canceled ) }) { newValue in
                    viewStore.send(.setSelectedDate(newValue))
                }
            }.greedyWidth()
        }
    }
}

private struct CalendarLabelView: View {
    fileprivate var body: some View {
        VStack(spacing: 8) {
            GCalendarLabel(title: "수업 예정일자", fillColor: .staticWhite, isUseStroke: true, strokeColor: .primaryNormal)
            GCalendarLabel(title: "완료된 수업", fillColor: .primaryNormal)
            GCalendarLabel(title: "미룬 수업", fillColor: .statusNegative)
        }
    }
}

private struct CalendarInfoView: View {
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentHomeFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(alignment: .leading ,spacing: 8) {
            GText(
                viewStore.selectedDate.formattedStringWithLocale(format: DateFormatConstants.classDetailSelectedDateFormat),
                fontStyle: .Body_1_Normal_B,
                color: .labelNormal
            )
            GText(
                getClassScheduleText(),
                fontStyle: .Label_1_Normal_B,
                color: .labelNeutral
            )
        }
        .vPadding(16)
        .hPadding(16)
        .greedyWidth(.leading)
        .background(Color.backgroundRegularAlternative)
        .cornerRadius(8)
    }
    
    private func getClassScheduleText() -> String {
        guard let classDetail = viewStore.classDetail else {
            return "수업이 없는 날이에요"
        }
        if let schedule = classDetail.schedules.first(where: { $0.date.toDateFromIntEpochMilliseconds().formattedString() == viewStore.selectedDate.formattedString() }) {
            switch schedule.status {
            case .canceled: return "수업을 미뤘어요"
            case .completed: return "수업 완료"
            case .scheduled: return "수업 진행 예정"
            }
        }
        return "수업이 없는 날이에요"
    }
}

private struct QRScanButton: View {
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentHomeFeature>) {
        self.viewStore = viewStore
    }
    
    private var isSelectedDateEqualsToday: Bool {
        viewStore.selectedDate.formattedString() == Date.now.formattedString()
    }
    
    private var hasSchedule: Bool {
        if let schedule = viewStore.classDetail?.schedules.first(where: {
            $0.date.toDateFromIntEpochMilliseconds().formattedString() == viewStore.selectedDate.formattedString()
        }) {
            return (schedule.status == .scheduled)
        } else {
            return false
        }
    }
    
    fileprivate var body: some View {
        if (isSelectedDateEqualsToday && hasSchedule) {
            GButton(
                title: "QR 인식하기",
                style: .enabled,
                buttonAction: { viewStore.send(.qrScanButtonTapped) }
            ).hPadding(16)
        }
    }
}

private struct AlertView: View {
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentHomeFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.alertCase {
        case .none:
            ZStack {}
        case .failure:
            GAlert(
                type: .includeIcon,
                title: "에러",
                contents: "알 수 없는 오류",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.alertAction(.dismiss))
                }
            )
        }
    }
}
