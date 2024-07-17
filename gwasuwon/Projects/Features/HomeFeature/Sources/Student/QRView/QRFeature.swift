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
        public init() {}
        
        var qrData: String = ""
        fileprivate var storedQrData: String = ""
    }

    public enum Action {
        case setQrData(String)
        case navigateToBackWithQRData(String)
        case navigateToBack
    }

    public var body: some ReducerOf<QRFeature> {
        Reduce { state, action in
            switch action {
            case let .setQrData(qrData):
                if (!qrData.isEmpty) {
                    state.qrData = qrData
                    if (state.qrData != state.storedQrData) {
                        state.storedQrData = qrData
                        return .send(.navigateToBackWithQRData(qrData))
                    }
                }
            case let .navigateToBackWithQRData(data):
                break
            case .navigateToBack:
                break
            }
            return .none
        }
    }
}
