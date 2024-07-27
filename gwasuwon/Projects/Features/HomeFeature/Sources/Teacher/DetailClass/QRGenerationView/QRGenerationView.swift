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
    
    private var navigationTitle: String {
        viewStore.isInvite ? "학생 초대 QR" : "수업 인증 QR"
    }
    
    private var descriptionText: String {
        viewStore.isInvite
         ? "학생이 앱을 설치한 상태에서\nQR 코드를 스캔하면 수업에 초대됩니다."
         : "선생님의 인증 QR을\n학생이 스캔해주세요"
    }
    
    fileprivate var body: some View {
        ZStack {
            GQRCodeGenerator(
                qrData: "\(viewStore.classId)",
                width: 240,
                height: 240
            )
            VStack(spacing: 0) {
                GNavigationBar(
                    title: navigationTitle,
                    leadingIcon: GImage.icBack.swiftUIImage,
                    leadingIconAction: {
                        viewStore.send(.navigateToBack)
                    }
                ).hPadding(16)
                GText(
                    descriptionText,
                    fontStyle: .Caption_1_R,
                    color: .labelNeutral,
                    lineLimit: 2
                )
                .padding(.top, 120)
                Spacer()
                if (viewStore.isInvite) {
                    GButton(
                        title: "수업 보기",
                        style: .enabled,
                        buttonAction: { viewStore.send(.navigateToBack) }
                    ).hPadding(16)
                }
            }
        }
    }
}
