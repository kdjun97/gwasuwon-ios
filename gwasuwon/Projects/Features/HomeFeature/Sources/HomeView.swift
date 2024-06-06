//
//  HomeView.swift
//  Home
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    let store: StoreOf<HomeFeature>
    @ObservedObject var viewStore: ViewStoreOf<HomeFeature>

    public init(store: StoreOf<HomeFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        HomeBody(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct HomeBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<HomeFeature>
    
    fileprivate init(viewStore: ViewStoreOf<HomeFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            Text("Home View!!!")
        }
    }
}
