//
//  SignInResponse.swift
//  Data
//
//  Created by 김동준 on 7/20/24
//

struct SignInResponse: Decodable {
    let id: Int
    let email: String
    let tokenType: String
    let accessToken: String
    let refreshToken: String
    let status: String
    let role: String
}
