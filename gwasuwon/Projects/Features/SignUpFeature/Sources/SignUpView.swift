//
//  SignUpView.swift
//  SignUp
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct SignUpView: View {
    let store: StoreOf<SignUpFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignUpFeature>

    public init(store: StoreOf<SignUpFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        SignUpBody(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct SignUpBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignUpFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignUpFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            SignUpContentsView().padding(.top, 200)
            Spacer()
            SignUpAgreementView(viewStore: viewStore).padding(.bottom, 16)
            SignUpBottomButton(viewStore: viewStore)
        }
    }
}

private struct SignUpContentsView: View {
    fileprivate var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GText(
                "만나서 반가워요!",
                fontStyle: .Display_2_B,
                color: .labelNormal
            ).padding(.bottom, 16)
            GText(
                "과수원의 원활한 이용을 위해,\n아래 약관에 동의해주세요.",
                fontStyle: .Label_1_Normal_R,
                color: .labelNormal,
                alignment: .leading,
                lineLimit: 2
            )
        }
        .hPadding(16)
        .greedyWidth(.leading)
    }
}

private struct SignUpAgreementView: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignUpFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignUpFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GCheckBox(
                title: "전체동의",
                isChecked: Binding(
                    get: { viewStore.isAllAgreementChecked },
                    set: { newValue in viewStore.send(.setAllAgreement(newValue)) }
                ),
                checkAction: { viewStore.send(.setAllAgreement(!viewStore.isAllAgreementChecked)) }
            )
            GCheckBox(
                title: "개인정보 수집 및 이용동의(필수)",
                isChecked: viewStore.$isPersonalInformationChecked,
                checkAction: { viewStore.send(.togglePersonalInformation) },
                trailingIcon: GImage.icMore.swiftUIImage,
                trailingAction: {}
            )
            GCheckBox(
                title: "과수원 약관(필수)",
                isChecked: viewStore.$isGwasuwonTermsChecked,
                checkAction: { viewStore.send(.toggleGwasuwonTerms) },
                trailingIcon: GImage.icMore.swiftUIImage,
                trailingAction: {}
            )
        }
    }
}

private struct SignUpBottomButton: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignUpFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignUpFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        GButton(
            title: "다음",
            style: viewStore.isAllAgreementChecked ? .enabled : .disabled,
            buttonAction: {
                viewStore.send(.nextButtonTapped)
            }
        )
    }
}
