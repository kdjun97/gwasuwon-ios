//
//  QRGenerationView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/25/24
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import QRScanner

public struct QRGenerationView: View {
    let store: StoreOf<QRGenerationFeature>
    @ObservedObject var viewStore: ViewStoreOf<QRGenerationFeature>

    public init(store: StoreOf<QRGenerationFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        QRGenerationBodyView(viewStore: viewStore)
            
    }
}

private struct QRGenerationBodyView: View {
    private let viewStore: ViewStoreOf<QRGenerationFeature>
    
    fileprivate init(viewStore: ViewStoreOf<QRGenerationFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            GQRCodeGenerator(
                qrData: viewStore.classId,
                width: 240,
                height: 240
            )
            VStack(spacing: 0) {
                GNavigationBar(
                    title: "학생 초대 QR",
                    leadingIcon: GImage.icBack.swiftUIImage,
                    leadingIconAction: {
                        viewStore.send(.navigateToBack)
                    }
                ).hPadding(16)
                GText(
                    "학생이 앱을 설치한 상태에서\nQR 코드를 스캔하면 수업에 초대됩니다.",
                    fontStyle: .Caption_1_R,
                    color: .labelNeutral,
                    lineLimit: 2
                )
                .padding(.top, 120)
                Spacer()
                GButton(
                    title: "수업 보기",
                    style: .enabled,
                    buttonAction: { viewStore.send(.navigateToBack) }
                ).hPadding(16)
            }
        }
    }
}
