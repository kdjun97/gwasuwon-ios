//
//  View+Extension.swift
//  BaseFeature
//
//  Created by 김동준 on 7/3/24
//

import Foundation
import SwiftUI
import ComposableArchitecture
import DesignSystem

public extension View {
    @ViewBuilder
    func gAlert(
        _ store: StoreOf<AlertFeature>,
        content: @escaping () -> some View
    ) -> some View {
        self.modifier(
            AlertViewModifier(
                viewStore: ViewStore(store, observe: { $0 }),
                alertContent: content
            )
        )
    }
}

private struct AlertViewModifier<AlertContent>: ViewModifier where AlertContent: View {
    @ObservedObject private var viewStore: ViewStoreOf<AlertFeature>
    let alertContent: () -> AlertContent

    fileprivate init(
        viewStore: ViewStoreOf<AlertFeature>,
        @ViewBuilder alertContent: @escaping () -> AlertContent
    ) {
        self.viewStore = viewStore
        self.alertContent = alertContent
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(viewStore.contentAllowsHitTesting)
            
            GColor.staticBlack.swiftUIColor
                .opacity(viewStore.scrimOpacity)
                .opacity(viewStore.endScrimOpacity)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    viewStore.send(.scrimTapped)
                }
            
            if viewStore.isPresented {
                alertContent()
            }
        }
    }
}
