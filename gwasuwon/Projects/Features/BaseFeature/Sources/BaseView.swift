//
//  BaseView.swift
//  Base
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture

public struct BaseView: View {
    let store: StoreOf<BaseFeature>
    @ObservedObject var viewStore: ViewStoreOf<BaseFeature>

    public init(store: StoreOf<BaseFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        BaseBody(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct BaseBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<BaseFeature>
    
    fileprivate init(viewStore: ViewStoreOf<BaseFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            Text("Base View!!!")
        }
    }
}
