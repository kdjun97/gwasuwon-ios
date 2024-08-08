//
//  QRGenerationFeature.swift
//  HomeFeature
//
//  Created by 김동준 on 7/25/24
//

import ComposableArchitecture
import Domain

@Reducer
public struct QRGenerationFeature {
    public init() {}

    public struct State: Equatable {
        public init(classId: Int, isInvite: Bool) {
            self.classId = classId
            self.isInvite = isInvite
        }
        
        var classId: Int
        let isInvite: Bool
    }

    public enum Action {
        case navigateToBack
    }

    public var body: some ReducerOf<QRGenerationFeature> {
        Reduce { state, action in
            switch action {
            case .navigateToBack:
                break
            }
            return .none
        }
    }
}
