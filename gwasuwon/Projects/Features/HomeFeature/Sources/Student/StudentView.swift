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
import BaseFeature

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
        .gLoading(isPresent: viewStore.$isLoading)
        .gAlert(self.store.scope(state: \.alertState, action: \.alertAction)) {
            AlertView(viewStore: viewStore)
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
            StudentContentsView
            Spacer()
            StudentBottomButton
        }
    }
    
    @ViewBuilder
    private var StudentContentsView: some View {
        if (viewStore.isInviteDone) {
            InviteDoneView
        } else {
            QRScanDescriptionView
        }
    }
    
    private var InviteDoneView: some View {
        VStack(spacing: 0) {
            GImage.icMainLogoLarge.swiftUIImage.resizedToFit(64, 64).padding(.bottom, 24)
            GText(
                "수업에 정상 초대되었습니다",
                fontStyle: .Title_3_B,
                color: .labelNormal
            ).padding(.bottom, 8)
            GText(
                "캘린더에서 수업 일정을 확인하고 관리해보세요",
                fontStyle: .Label_1_Normal_R,
                color: .labelNeutral
            )
        }
    }
    
    private var QRScanDescriptionView: some View {
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
    }
    
    private var StudentBottomButton: some View {
        if (viewStore.isInviteDone) {
            GButton(
                title: "캘린더로 이동",
                style: .enabled,
                buttonAction: {
                    viewStore.send(.moveToCalendarButtonTapped)
                }
            ).hPadding(16)
        } else {
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

private struct AlertView: View {
    private let viewStore: ViewStoreOf<StudentFeature>
    
    fileprivate init(viewStore: ViewStoreOf<StudentFeature>) {
        self.viewStore = viewStore
    }
    
    fileprivate var body: some View {
        switch viewStore.alertCase {
        case .none: EmptyView()
        case .failure:
            GAlert(
                type: .includeIcon,
                title: "에러",
                contents: "알 수 없는 에러",
                defaultButtonTitle: "확인",
                defaultButtonAction: {
                    viewStore.send(.alertAction(.dismiss))
                }
            )
        }
    }
}
