//
//  SignUpRoleView.swift
//  SignUpFeature
//
//  Created by 김동준 on 7/11/24
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import BaseFeature

public struct SignUpRoleView: View {
    let store: StoreOf<SignUpRoleFeature>
    @ObservedObject var viewStore: ViewStoreOf<SignUpRoleFeature>

    public init(store: StoreOf<SignUpRoleFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        SignUpRoleBody(viewStore: viewStore)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.alertState, action: \.alertAction)) {
            GAlert(
                type: .includeIcon,
                title: "에러",
                contents: "회원 가입 실패",
                extraButtonTitle: "확인",
                extraButtonAction: {
                    viewStore.send(.alertAction(.dismiss))
                }
            )
        }
    }
}

private struct SignUpRoleBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignUpRoleFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignUpRoleFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GText(
                "수업에서 당신의\n역할을 알려주세요",
                fontStyle: .Title_2_B,
                color: .labelNormal,
                lineLimit: 2
            ).padding(.bottom, 72)
            SignUpRoleSelectView(viewStore: viewStore)
        }
    }
}

private struct SignUpRoleSelectView: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignUpRoleFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignUpRoleFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 8) {
            SignUpRoleItemView(
                title: "선생님이에요",
                image: GImage.icTeacher.swiftUIImage,
                action: { viewStore.send(.teacherButtonTapped) }
            )
            SignUpRoleItemView(
                title: "학생이에요",
                image: GImage.icStudent.swiftUIImage,
                action: { viewStore.send(.studentButtonTapped) }
            )
        }
    }
}

private struct SignUpRoleItemView: View {
    let title: String
    let image: Image
    let action: () -> Void
    
    fileprivate init(title: String, image: Image, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.action = action
    }
    
    fileprivate var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                GText(
                    title,
                    fontStyle: .Headline_1_B,
                    color: .labelNormal,
                    alignment: .center
                )
                .greedyWidth()
                image.padding(.leading, 16).vPadding(12).greedyWidth(.leading)
            }
            .background(Color.backgroundElevatedAlternative)
            .cornerRadius(8)
            .hPadding(16)
            .greedyWidth()
        }
    }
}
