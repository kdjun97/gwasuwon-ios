//
//  DetailClassView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/14/24
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import BaseFeature
import Util

public struct DetailClassView: View {
    let store: StoreOf<DetailClassFeature>
    @ObservedObject var viewStore: ViewStoreOf<DetailClassFeature>

    public init(store: StoreOf<DetailClassFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        DetailClassBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.detailClassAlertState, action: \.detailClassAlertAction)) {
            DetailClassAlertView(viewStore: viewStore)
        }
    }
}

private struct DetailClassBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<DetailClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<DetailClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            DetailClassNavigationBar(viewStore: viewStore).hPadding(16)
            ScrollView {
                GCalendar(viewStore: viewStore).padding(.bottom, 16).hPadding(16)
                CalendarLabelView().padding(.bottom, 24).hPadding(16)
                CalendarInfoView(viewStore: viewStore).hPadding(16)
            }
            Spacer()
            GButton(
                title: "학생 초대 QR",
                style: .enabled,
                buttonAction: {}
            ).hPadding(16)
        }
    }
}

private struct DetailClassNavigationBar: View {
    @ObservedObject var viewStore: ViewStoreOf<DetailClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<DetailClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        HStack(spacing: 0) {
            GNavigationBar(
                title: "수업 목록",
                leadingIcon: GImage.icBack.swiftUIImage,
                leadingIconAction: {
                    viewStore.send(.navigateToBack)
                }
            )
            Spacer()
            Menu {
                Section {
                    Button {
                        viewStore.send(.classMenuInformationButtonTapped)
                    } label: {
                        GText("수업 정보", fontStyle: .Label_1_Normal_R, color: .labelNormal).padding(8)
                    }
                    Button {
                        viewStore.send(.classMenuDeleteButtonTapped)
                    } label: {
                        GText("수업 삭제", fontStyle: .Label_1_Normal_R, color: .labelNormal).padding(8)
                    }
                }
            } label: {
                GImage.icMoreCircle.swiftUIImage.resizedToFit(20, 20)
            }.padding(.trailing, 8)
        }.padding(.bottom, 16)
    }
}

private struct GCalendar: View {
    @ObservedObject var viewStore: ViewStoreOf<DetailClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<DetailClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        if let classDetail = viewStore.classDetail {
            VStack {
                GCalenderView(schedules: classDetail.schedules) { newValue in
                    print("DONGJUN -> \(newValue.formattedString(format: DateFormatConstants.defaultFormat)) 선택함")
                    // TODO: Implement logic
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
    @ObservedObject var viewStore: ViewStoreOf<DetailClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<DetailClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 8) {
            GText(
                "7월 3일(수)",
                fontStyle: .Body_1_Normal_B,
                color: .labelNormal
            )
            GText(
                "수업 진행 예정",
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
}

private struct DetailClassAlertView: View {
    @ObservedObject var viewStore: ViewStoreOf<DetailClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<DetailClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.detailClassAlertCase {
        case .fetchClassDetailFailure:
            GAlert(
                type: .includeIcon,
                title: "에러",
                contents: "정보 불러오기를 실패했습니다.",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.detailClassAlertAction(.dismiss))
                }
            )
        case .delete:
            GAlert(
                type: .includeIcon,
                title: "수업 삭제",
                contents: "수업을 삭제하시겠습니까?",
                defaultButtonTitle: "취소",
                defaultButtonAction: {
                    viewStore.send(.detailClassAlertAction(.dismiss))
                },
                extraButtonTitle: "삭제",
                extraButtonAction: {
                    viewStore.send(.alertDeleteButtonTapped)
                }
            )
        case .none:
            ZStack {}
        }
    }
}
