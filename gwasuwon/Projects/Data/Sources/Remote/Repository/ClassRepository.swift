//
//  ClassRepository.swift
//  Data
//
//  Created by 김동준 on 7/11/24
//

import Domain

public struct ClassRepository: ClassRepositoryProtocol {
    private let apiService: ApiService
    
    public init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    public func getClassList() async -> Result<[ClassInformation], NetworkError> {
        // TODO: Implement this api call
        return .failure(.badRequest)
    }
    
    public func getDetailClass() async -> Result<ClassInformation, NetworkError> {
        // TODO: Implement this api call
        return .failure(.badRequest)
    }
}
