//
//  StudentView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import BaseFeature

struct StudentView: View {
    let store: StoreOf<StudentFeature>
    @ObservedObject var viewStore: ViewStoreOf<StudentFeature>
    
    public init(store: StoreOf<StudentFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        StudentBodyView(store: store, viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.alertState, action: \.alertAction)) {
            AlertView(viewStore: viewStore)
        }
    }
}

private struct StudentBodyView: View {
    private let store: StoreOf<StudentFeature>
    private let viewStore: ViewStoreOf<StudentFeature>
    
    fileprivate init(store: StoreOf<StudentFeature>, viewStore: ViewStoreOf<StudentFeature>) {
        self.store = store
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.classVisibleType {
        case .hasSchedule:
            StudentHomeView(store: store.scope(state: \.studentHomeState, action: \.studentHomeAction))
        case .noSchedule:
            StudentNoScheduleView(store: store.scope(state: \.studentNoScheduleState, action: \.studentNoScheduleAction))
        case .none:
            ZStack {}
        }
    }
}

private struct AlertView: View {
    private let viewStore: ViewStoreOf<StudentFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.alertCase {
        case .none: EmptyView()
        case .failure:
            GAlert(
                type: .includeIcon,
                title: "에러",
                contents: "알 수 없는 에러",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.alertAction(.dismiss))
                }
            )
        }
    }
}
