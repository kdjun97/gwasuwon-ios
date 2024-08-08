//
//  SignUpCompleteView.swift
//  SignUpFeature
//
//  Created by 김동준 on 7/12/24
//

import Foundation
import ComposableArchitecture
import SwiftUI
import DesignSystem

public struct SignUpCompleteView: View {
    let store: StoreOf<SignUpCompleteFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignUpCompleteFeature>

    public init(store: StoreOf<SignUpCompleteFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        SignUpCompleteBody(viewStore: viewStore)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct SignUpCompleteBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignUpCompleteFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignUpCompleteFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GImage.icMainLogoLarge.swiftUIImage.resizedToFit(64, 64).padding(.bottom, 24)
                GText(
                    "회원가입이 완료되었어요",
                    fontStyle: .Title_3_B,
                    color: .labelNormal
                ).padding(.bottom, 8)
                GText(
                    "과수원과 함께 수업을 시작해볼까요?",
                    fontStyle: .Label_1_Normal_R,
                    color: .labelNeutral
                )
            }
            GButton(
                title: "수업 시작하기",
                style: .enabled,
                buttonAction: { viewStore.send(.startClassButtonTapped) }
            )
            .hPadding(16)
            .greedyHeight(.bottom)
        }
    }
}
