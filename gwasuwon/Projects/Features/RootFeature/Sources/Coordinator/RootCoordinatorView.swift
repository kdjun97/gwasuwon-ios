//
//  RootCoordinatorView.swift
//  RootFeature
//
//  Created by 김동준 on 6/6/24
//

import Foundation
import TCACoordinators
import ComposableArchitecture
import SwiftUI
import SignInFeature
import SignUpFeature
import HomeFeature

public struct RootCoordinatorView: View {
    let store: StoreOf<RootCoordinator>
    
    public init(store: StoreOf<RootCoordinator>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) { screen in
                switch screen {
                case .signIn:
                    CaseLet(/RootScreen.State.signIn, action: RootScreen.Action.signIn, then: SignInView.init)
                case .signUp:
                    CaseLet(/RootScreen.State.signUp, action: RootScreen.Action.signUp, then: SignUpView.init)
                case .home:
                    CaseLet(/RootScreen.State.home, action: RootScreen.Action.home, then: HomeView.init)
                case .signUpRole:
                    CaseLet(/RootScreen.State.signUpRole, action: RootScreen.Action.signUpRole, then: SignUpRoleView.init)
                case .signUpComplete:
                    CaseLet(/RootScreen.State.signUpComplete, action: RootScreen.Action.signUpComplete, then: SignUpCompleteView.init)
                case .addClass:
                    CaseLet(/RootScreen.State.addClass, action: RootScreen.Action.addClass, then: AddClassView.init)
                case .addClassDetail:
                    CaseLet(/RootScreen.State.addClassDetail, action: RootScreen.Action.addClassDetail, then: AddClassDetailView.init)
                case .addClassDone:
                    CaseLet(/RootScreen.State.addClassDone, action: RootScreen.Action.addClassDone, then: AddClassDoneView.init)
                case .detailClass:
                    CaseLet(/RootScreen.State.detailClass, action: RootScreen.Action.detailClass, then: DetailClassView.init)
                case .qrCode:
                    CaseLet(/RootScreen.State.qrCode, action: RootScreen.Action.qrCode, then: QRView.init)
                case .qrGenerator:
                    CaseLet(/RootScreen.State.qrGenerator, action: RootScreen.Action.qrGenerator, then: QRGenerationView.init)
                case .editClass:
                    CaseLet(/RootScreen.State.editClass, action: RootScreen.Action.editClass, then: EditClassView.init)
                }
            }
        }
    }
}
