//
//  StudentFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/17/24
//

import ComposableArchitecture
import Domain

@Reducer
public struct StudentFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
        
        var isCameraPermissionGranted: Bool = false
        var qrResult: String = ""
        var isInviteDone: Bool = false
    }

    public enum Action {
        case qrScanButtonTapped
        case setCameraPermissionIsGranted(Bool)
        case setQRResult(String)
        case inviteClassDone
        case navigateToStudentDetail
    }

    public var body: some ReducerOf<StudentFeature> {
        Reduce { state, action in
            switch action {
            case .qrScanButtonTapped:
                break
            case let .setCameraPermissionIsGranted(value):
                state.isCameraPermissionGranted = value
            case let .setQRResult(data):
                state.qrResult = data
                return .send(.inviteClassDone)
            case .inviteClassDone:
                state.isInviteDone = true
            case .navigateToStudentDetail:
                break
            }
            return .none
        }
    }
}
