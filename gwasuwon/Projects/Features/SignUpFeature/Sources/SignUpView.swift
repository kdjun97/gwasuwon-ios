//
//  SignUpView.swift
//  SignUp
//
//  Created by 김동준 
//

import SwiftUI
import ComposableArchitecture

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
        ZStack {
            Text("SignUp View!!!")
        }
    }
}
