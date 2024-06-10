//
//  Encodable+Extension.swift
//  Data
//
//  Created by 김동준 on 6/8/24
//

import Foundation

extension Encodable {
    public func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [String: Any]
    }
}
