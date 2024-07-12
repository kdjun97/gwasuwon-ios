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
            ScrollView {
                
            }
            Spacer()
            GButton(
                title: "다음",
                style: .disabled,
                buttonAction: {}
            )
        }.hPadding(16)
    }
}
