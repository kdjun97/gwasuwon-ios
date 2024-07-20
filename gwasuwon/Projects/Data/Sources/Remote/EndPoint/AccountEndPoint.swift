//
//  AccountEndPoint.swift
//  Data
//
//  Created by 김동준 on 6/7/24
//

import Foundation

enum AccountEndPoint {
    case signIn(String)
    
    var url: String {
        switch self {
        case .signIn(let provider):
            "/api/v1/auth/login/\(provider)"
        }
    }
}
