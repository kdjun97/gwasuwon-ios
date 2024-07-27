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
    @StateObject private var permissionManager = CameraPermissionManager()

    public init(store: StoreOf<QRFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    public var body: some View {
        QRBodyView(viewStore: viewStore)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            permissionManager.requestCameraPermission()
        }
        .onReceive(permissionManager.$isCameraPermissionGranted) { isGranted in
            viewStore.send(.setCameraPermissionIsGranted(isGranted))
        }
    }
}

private struct QRBodyView: View {
    private let viewStore: ViewStoreOf<QRFeature>
    
    fileprivate init(viewStore: ViewStoreOf<QRFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            if viewStore.isCameraPermissionGranted {
                CameraPermissionGrantedView(viewStore: viewStore)
            } else {
                CameraPermissionIsNotGrantedView(viewStore: viewStore)
            }
        }
    }
}

private struct CameraPermissionGrantedView: View {
    @ObservedObject private var viewStore: ViewStoreOf<QRFeature>
    
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

private struct CameraPermissionIsNotGrantedView: View {
    private let viewStore: ViewStoreOf<QRFeature>
    
    fileprivate init(viewStore: ViewStoreOf<QRFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        ZStack {
            GText(
                "카메라 권한을 설정해주세요.",
                fontStyle: .Body_1_Normal_R,
                color: .labelAlternative
            )
            VStack(spacing: 0) {
                Spacer()
                GButton(
                    title: "권한 설정 하기",
                    style: .enabled
                ) {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsURL)
                    }
                }.hPadding(16)
            }
        }
    }
}
