//
//  RefreshTokenResponse.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

struct RefreshTokenResponse : Decodable {
    let accessToken: String
    let refreshToken: String
}
