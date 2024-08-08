//
//  App.swift
//  App
//
//  Created by 김동준 on 6/5/24
//

import SwiftUI
import RootFeature
import ComposableArchitecture
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate

    init() {
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""

        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(
                store: Store(
                    initialState: RootCoordinator.State(),
                    reducer: { RootCoordinator() }
                )
            )
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
            .onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
