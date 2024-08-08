//
//  HomeView.swift
//  Home
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct HomeView: View {
    let store: StoreOf<HomeFeature>
    @ObservedObject var viewStore: ViewStoreOf<HomeFeature>

    public init(store: StoreOf<HomeFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        HomeBody(store: store, viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct HomeBody: View {
    private var store: StoreOf<HomeFeature>
    @ObservedObject private var viewStore: ViewStoreOf<HomeFeature>
    
    fileprivate init(store: StoreOf<HomeFeature>, viewStore: ViewStoreOf<HomeFeature>) {
        self.store = store
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            if (viewStore.role == .teacher) {
                TeacherView(store: store.scope(state: \.teacherState, action: \.teacherAction))
            } else {
                StudentView(store: store.scope(state: \.studentState, action: \.studentAction))
            }
        }
    }
}
