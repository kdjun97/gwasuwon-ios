//
//  SignInView.swift
//  SignIn
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import BaseFeature

public struct SignInView: View {
    let store: StoreOf<SignInFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignInFeature>

    public init(store: StoreOf<SignInFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        SignInBody(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.alertState, action: SignInFeature.Action.alertAction)) {
            AlertView(viewStore: viewStore)
        }
    }
}

private struct SignInBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignInFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignInFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            MainLogoInfoView()
            Spacer()
            SocialLoginButtonView(viewStore: viewStore)
        }
    }
}

private struct MainLogoInfoView: View {
    fileprivate var body: some View {
        ZStack {
            VStack(spacing: 0) {
                GImage.icMainLogoLarge.swiftUIImage.resizedToFit(88, 88)
                GImage.icMainLogoLetterMedium.swiftUIImage.vPadding(16)
                GText(
                    "과외 수업을 원하는 사람들",
                    fontStyle: .Body_1_Normal_R,
                    color: .primaryNormal
                )
                .padding(.top, 24)
            }
        }.greedyHeight()
    }
}

private struct SocialLoginButtonView: View {
    let viewStore: ViewStoreOf<SignInFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignInFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 8) {
            GLeadingButton(
                title: "카카오 로그인",
                titleColor: .staticBlack,
                backgroundColor: .socialKakao,
                leadingIcon: GImage.icKakao.swiftUIImage,
                buttonAction: {
                    viewStore.send(.kakaoButtonTapped)
                }
            )
            GLeadingButton(
                title: "Apple 로그인",
                titleColor: .staticWhite,
                backgroundColor: .staticBlack,
                leadingIcon: GImage.icApple.swiftUIImage,
                buttonAction: {
                    viewStore.send(.appleButtonTapped)
                }
            )
        }
    }
}

private struct AlertView: View {
    @ObservedObject var viewStore: ViewStoreOf<SignInFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignInFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.alertCase {
        case .none:
            ZStack {}
        case .failure:
            GAlert(
                type: .includeIcon,
                title: "로그인 실패",
                contents: "아이디, 비밀번호를 확인해주세요",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.alertAction(.dismiss))
                }
            )
        }
    }
}
