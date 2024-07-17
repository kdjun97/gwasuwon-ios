//
//  StudentView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/11/24
//

import SwiftUI
import ComposableArchitecture

struct StudentView: View {
    let store: StoreOf<StudentFeature>
    @ObservedObject var viewStore: ViewStoreOf<StudentFeature>

    public init(store: StoreOf<StudentFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Stutdent View")
        }
    }
}
