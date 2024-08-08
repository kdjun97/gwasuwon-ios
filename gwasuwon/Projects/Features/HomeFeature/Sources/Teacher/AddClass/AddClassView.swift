//
//  AddClassView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/12/24
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct AddClassView: View {
    let store: StoreOf<AddClassFeature>
    @ObservedObject var viewStore: ViewStoreOf<AddClassFeature>

    public init(store: StoreOf<AddClassFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        AddClassBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct AddClassBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<AddClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassFeature>) {
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
            )
            GText(
                "기본 정보",
                fontStyle: .Headline_1_B,
                color: .labelNormal
            )
            .greedyWidth(.leading)
            .vPadding(24)
            StudentInformationView(viewStore: viewStore)
            Spacer()
            GButton(
                title: "다음",
                style: viewStore.isNextButtonEnabled ? .enabled : .disabled,
                buttonAction: { viewStore.send(.nextButtonTapped) }
            )
        }.hPadding(16)
    }
}

private struct StudentInformationView: View {
    @ObservedObject var viewStore: ViewStoreOf<AddClassFeature>
    
    fileprivate init(viewStore: ViewStoreOf<AddClassFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ScrollView {
            VStack(spacing: 40) {
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
    }
}
