//
//  ResultMapper.swift
//  Data
//
//  Created by 김동준 on 6/7/24
//

import Foundation
import Domain

struct ResultMapper<T: Codable> {
    func toMap(_ result: Result<Data, NetworkError>) -> Result<T, NetworkError> {
        switch result {
        case let .success(data):
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(NetworkError.decodingError)
            }
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
}
