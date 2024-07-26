//
//  StudentHomeView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/26/24
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

struct StudentHomeView: View {
    let store: StoreOf<StudentHomeFeature>
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>

    public init(store: StoreOf<StudentHomeFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        StudentHomeBodyView(viewStore: viewStore)
        .onAppear {
            viewStore.send(.onAppear)
        }
    }
}

private struct StudentHomeBodyView: View {
    @ObservedObject var viewStore: ViewStoreOf<StudentHomeFeature>

    fileprivate init(viewStore: ViewStoreOf<StudentHomeFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            Text("Student Home")
        }
    }
}
