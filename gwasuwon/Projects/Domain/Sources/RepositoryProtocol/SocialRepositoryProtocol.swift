//
//  SocialRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 7/19/24
//

public protocol SocialRepositoryProtocol {
    func signInWithKakao() async -> Result<String, NetworkError>
}
