//
//  StudentView.swift
//  HomeFeature
//
//  Created by 김동준 on 7/11/24
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import QRScanner

struct StudentView: View {
    let store: StoreOf<StudentFeature>
    @ObservedObject var viewStore: ViewStoreOf<StudentFeature>
    @StateObject private var permissionManager = CameraPermissionManager()

    public init(store: StoreOf<StudentFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        StudentBodyView(viewStore: viewStore)
        .onAppear {
            permissionManager.requestCameraPermission()
        }
        .onReceive(permissionManager.$isCameraPermissionGranted) { isGranted in
            viewStore.send(.setCameraPermissionIsGranted(isGranted))
        }
    }
}

private struct StudentBodyView: View {
    private let viewStore: ViewStoreOf<StudentFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        VStack(spacing: 0) {
            GNavigationBar(title: "수업 초대받기")
            Spacer()
            if (viewStore.isCameraPermissionGranted) {
                GText(
                    "선생님의 QR 코드를 인식해주세요.",
                    fontStyle: .Body_1_Normal_R,
                    color: .labelAlternative
                )
            } else {
                GText(
                    "카메라 권한을 설정해주세요.",
                    fontStyle: .Body_1_Normal_R,
                    color: .labelAlternative
                )
            }
            Spacer()
            GButton(
                title: "QR 인식하기",
                style: viewStore.isCameraPermissionGranted ? .enabled : .disabled,
                buttonAction: {
                    viewStore.send(.qrScanButtonTapped)
                }
            ).hPadding(16)
        }
    }
}
