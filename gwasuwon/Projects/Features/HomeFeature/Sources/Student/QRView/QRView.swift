//
//  QRView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/17/24
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import QRScanner

public struct QRView: View {
    let store: StoreOf<QRFeature>
    @ObservedObject var viewStore: ViewStoreOf<QRFeature>

    public init(store: StoreOf<QRFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        QRBodyView(viewStore: viewStore)
        .navigationBarBackButtonHidden(true)
    }
}

private struct QRBodyView: View {
    private let viewStore: ViewStoreOf<QRFeature>
    
    fileprivate init(viewStore: ViewStoreOf<QRFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            GQRScanner(result: Binding(get: { viewStore.qrData }, set: { newValue in viewStore.send(.setQrData(newValue)) }))
            Button {
                viewStore.send(.navigateToBack)
            } label: {
                GImage.icBack.swiftUIImage.resizedToFit(40,40)
            }.greedyFrame(.topLeading)
            GText(
                "QR 코드를 인식해주세요",
                fontStyle: .Body_1_Normal_B,
                color: .staticWhite
            ).padding(.bottom, 24).greedyHeight(.bottom)
        }
    }
}
