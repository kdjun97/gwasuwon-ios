//
//  SignUpResponse.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

struct SignUpResponse: Decodable {
    let id: Int
    let email: String
    let role: String
    let status: String
}
