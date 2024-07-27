//
//  QRFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/17/24
//

import ComposableArchitecture
import Domain

@Reducer
public struct QRFeature {
    public init() {}

    public struct State: Equatable {
        public init(isInvite: Bool) {
            self.isInvite = isInvite
        }
        
        var qrData: String = ""
        fileprivate var storedQrData: String = ""
        
        var isCameraPermissionGranted: Bool = false
        var qrResult: String = ""
        let isInvite: Bool
    }

    public enum Action {
        case setQrData(String)
        case navigateToBackWithQRData(String, Bool)
        case navigateToBack
        case setCameraPermissionIsGranted(Bool)
    }

    public var body: some ReducerOf<QRFeature> {
        Reduce { state, action in
            switch action {
            case let .setQrData(qrData):
                if (!qrData.isEmpty) {
                    state.qrData = qrData
                    if (state.qrData != state.storedQrData) {
                        state.storedQrData = qrData
                        return .send(.navigateToBackWithQRData(qrData, state.isInvite))
                    }
                }
            case let .navigateToBackWithQRData(data, isInvite):
                print("DONGJUN -> \(data) / \(isInvite)")
                break
            case .navigateToBack:
                break
            case let .setCameraPermissionIsGranted(value):
                state.isCameraPermissionGranted = value
            }
            return .none
        }
    }
}
