//
//  AddClassDoneView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/14/24
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import BaseFeature

public struct AddClassDoneView: View {
    let store: StoreOf<AddClassDoneFeature>
    @ObservedObject var viewStore: ViewStoreOf<AddClassDoneFeature>

    public init(store: StoreOf<AddClassDoneFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        AddClassDoneBodyView(viewStore: viewStore)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gAlert(self.store.scope(state: \.addClassDoneAlertState, action: \.addClassDoneAlertAction)) {
            GAlert(
                type: .onlyContents,
                title: "링크 복사",
                contents: "링크가 클립보드에 복사되었습니다",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.addClassDoneAlertAction(.dismiss))
                }
            )
        }
    }
}

private struct AddClassDoneBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<AddClassDoneFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDoneFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GImage.icMainLogoLarge.swiftUIImage.resizedToFit(64, 64).padding(.top, 40).padding(.bottom, 22)
            GText(
                "수업 생성이 완료되었어요!",
                fontStyle: .Headline_1_B,
                color: .labelNormal
            ).padding(.bottom, 52)
            GuideInfoView()
            Spacer()
            AddClassDoneButtonView(viewStore: viewStore)
        }
    }
}

private struct GuideInfoView: View {
    fileprivate var body: some View {
        VStack(spacing: 12) {
            GText(
                "1. 링크 공유를 통해 과외 계약서를 전달하세요.",
                fontStyle: .Label_2_R,
                color: .labelNeutral
            )
            .hPadding(8)
            .vPadding(8)
            .greedyWidth(.leading)
            .background(Color.backgroundElevatedAlternative)
            .cornerRadius(8)
            GText(
                "2. QR 코드를 통해 학생을 과수원 앱에 초대하세요.",
                fontStyle: .Label_2_R,
                color: .labelNeutral
            )
            .hPadding(8)
            .vPadding(8)
            .greedyWidth(.leading)
            .background(Color.backgroundElevatedAlternative)
            .cornerRadius(8)
            GText(
                "3. 학생 초대, 계약 진행이 완료된 이후 수업을 진행하세요.",
                fontStyle: .Label_2_R,
                color: .labelNeutral
            )
            .hPadding(8)
            .vPadding(8)
            .greedyWidth(.leading)
            .background(Color.backgroundElevatedAlternative)
            .cornerRadius(8)
        }.hPadding(16)
    }
}

private struct AddClassDoneButtonView: View {
    @ObservedObject var viewStore: ViewStoreOf<AddClassDoneFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassDoneFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View  {
        VStack(spacing: 8) {
            GButton(
                title: "과외 계약서 보내기",
                style: .enabled,
                buttonAction: {
                    UIPasteboard.general.string = "복사된 텍스트+\(viewStore.tempId)"
                    viewStore.send(.sendContractButtonTapped)
                }
            )
            GButton(
                title: "수업 정보 보기",
                style: .outline,
                buttonAction: {
                    viewStore.send(.showClassInfoButtonTapped(viewStore.tempId))
                }
            )
        }.hPadding(16)
    }
}
