//
//  AccountRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 6/7/24
//

public protocol AccountRepositoryProtocol {
    func postSignIn(provider: String, thirdPartyAccessToken: String) async -> Result<SignInResult, NetworkError>
}
