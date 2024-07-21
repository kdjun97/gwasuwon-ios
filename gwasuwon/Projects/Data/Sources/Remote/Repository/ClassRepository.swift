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
    
    public func getClassList() async -> Result<ClassInformation, NetworkError> {
        let responseData = await apiService.callApiService(
            httpMethod: .GET,
            endPoint: ClassEndPoint.classList.url
        )
        let entityDataResult = ResultMapper<ClassListResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            return .success(ClassMapper.toClassInformationList(response: response))
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
    
    public func getDetailClass() async -> Result<ClassInformation, NetworkError> {
        // TODO: Implement this api call
        return .failure(.badRequest)
    }
}
