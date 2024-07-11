//
//  SignUpFeature.swift
//  SignUp
//
//  Created by 김동준
//

import ComposableArchitecture

@Reducer
public struct SignUpFeature {
    public init() {}

    public struct State: Equatable {
        public init() {}
        var isAllAgreementChecked: Bool {
            get {
                isPersonalInformationChecked && isGwasuwonTermsChecked
            }
            
            set(value) {
                isPersonalInformationChecked = value
                isGwasuwonTermsChecked = value
            }
        }
        @BindingState var isPersonalInformationChecked: Bool = false
        @BindingState var isGwasuwonTermsChecked: Bool = false
    }

    public enum Action: BindableAction, Equatable {
        case onAppear
        case binding(BindingAction<State>)
        case setAllAgreement(Bool)
        case togglePersonalInformation
        case toggleGwasuwonTerms
        case nextButtonTapped
    }

    public var body: some ReducerOf<SignUpFeature> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                break
            case .binding:
                break
            case let .setAllAgreement(value):
                state.isAllAgreementChecked = value
            case .togglePersonalInformation:
                state.isPersonalInformationChecked.toggle()
            case .toggleGwasuwonTerms:
                state.isGwasuwonTermsChecked.toggle()
            case .nextButtonTapped:
                break
            }
            return .none
        }
    }
}
