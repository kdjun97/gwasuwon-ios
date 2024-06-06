//
//  SignInView.swift
//  SignIn
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture

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
    }
}

private struct SignInBody: View {
    @ObservedObject private var viewStore: ViewStoreOf<SignInFeature>
    
    fileprivate init(viewStore: ViewStoreOf<SignInFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            Text("SignIn View!!!")
        }
    }
}
