//
//  ClassEndPoint.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

import Foundation

enum ClassEndPoint {
    case classList
    
    var url: String {
        switch self {
        case .classList:
            "/api/v1/classes"
        }
    }
}

