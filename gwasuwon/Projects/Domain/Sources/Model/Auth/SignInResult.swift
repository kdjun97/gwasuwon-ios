//
//  SignInResult.swift
//  Domain
//
//  Created by 김동준 on 7/20/24
//

public struct SignInResult: Equatable {
    public let id: Int
    public let email: String
    public let accessToken: String
    public let refreshToken: String
    public let status: String
    public let role: String
    
    public init(
        id: Int,
        email: String,
        accessToken: String,
        refreshToken: String,
        status: String, 
        role: String
    ) {
        self.id = id
        self.email = email
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.status = status
        self.role = role
    }
}
