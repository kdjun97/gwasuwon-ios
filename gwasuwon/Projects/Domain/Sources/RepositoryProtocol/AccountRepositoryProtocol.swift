//
//  AccountRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 6/7/24
//

public protocol AccountRepositoryProtocol {
    func postSignIn(provider: String, thirdPartyAccessToken: String) async -> Result<SignInResult, NetworkError>
    func postSignUp(accessToken: String, type: String) async -> Result<SignUpResult, NetworkError>
}
