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
    }

    public enum Action {
        case qrScanButtonTapped
        case setCameraPermissionIsGranted(Bool)
    }

    public var body: some ReducerOf<StudentFeature> {
        Reduce { state, action in
            switch action {
            case .qrScanButtonTapped:
                break
            case let .setCameraPermissionIsGranted(value):
                state.isCameraPermissionGranted = value
            }
            return .none
        }
    }
}
