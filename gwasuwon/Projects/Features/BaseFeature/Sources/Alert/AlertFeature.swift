//
//  AlertFeature.swift
//  BaseFeature
//
//  Created by 김동준 on 7/3/24
//

import ComposableArchitecture
import Foundation

@Reducer
public struct AlertFeature {
    public init() {}
    
    public struct State: Equatable {
        internal var scrimOpacity: CGFloat
        internal var contentAllowsHitTesting: Bool
        public internal(set) var isPresented: Bool
        public var endScrimOpacity: CGFloat = 0.75
        public var dismissOnScrimTap: Bool

        public init(dismissOnScrimTap: Bool = true) {
            scrimOpacity = .zero
            contentAllowsHitTesting = true
            isPresented = false
            self.dismissOnScrimTap = dismissOnScrimTap
        }
    }

    public enum Action: Equatable {
        case present
        case dismiss
        case scrimTapped
        case scrimOpacityChanged(opacity: CGFloat)
    }

    public var body: some ReducerOf<AlertFeature> {
        Reduce { state, action in
            switch action {
            case .present:
                state.isPresented = true
                state.contentAllowsHitTesting = false
                return .send(.scrimOpacityChanged(opacity: 0.75))

            case .dismiss:
                state.isPresented = false
                state.contentAllowsHitTesting = true
                return .send(.scrimOpacityChanged(opacity: .zero))
                
            case .scrimTapped:
                guard state.dismissOnScrimTap else { return .none }
                return .run { send in
                    await send(.dismiss)
                }

            case let .scrimOpacityChanged(opacity):
                state.scrimOpacity = opacity
                return .none
            }
        }
    }
}
