//
//  SignUpResult.swift
//  Domain
//
//  Created by 김동준 on 7/21/24
//

public struct SignUpResult: Equatable {
    public let id: Int
    public let email: String
    public let role: String
    public let status: String
    
    public init(
        id: Int,
        email: String,
        role: String,
        status: String
    ) {
        self.id = id
        self.email = email
        self.role = role
        self.status = status
    }
}
