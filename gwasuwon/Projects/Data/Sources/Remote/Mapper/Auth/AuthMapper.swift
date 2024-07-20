//
//  AuthMapper.swift
//  Data
//
//  Created by 김동준 on 7/20/24
//

import Domain

class AuthMapper {
    static func toSignInResult(response: SignInResponse) -> SignInResult {
        return SignInResult(
            id: response.id,
            email: response.email,
            accessToken: response.accessToken,
            refreshToken: response.refreshToken,
            status: response.status,
            role: response.role
        )
    }
}
