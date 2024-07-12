//
//  App.swift
//  App
//
//  Created by 김동준 on 6/5/24
//

import SwiftUI
import RootFeature
import ComposableArchitecture

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(
                store: Store(
                    initialState: RootCoordinator.State(),
                    reducer: { RootCoordinator() }
                )
            )
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
