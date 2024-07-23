//
//  SignUpRequest.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

struct SignUpRequest: Encodable {
    let privacyPolicyAgreement: Bool
    let termsOfServiceAgreement: Bool
    let role: String
}
