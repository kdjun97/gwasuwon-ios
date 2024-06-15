//
//  AccountRepository.swift
//  Data
//
//  Created by 김동준 on 6/7/24
//

import Domain

public struct AccountRepository: AccountRepositoryProtocol {
    private let apiService: ApiService
    
    public init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    public func getApiTest() async -> Result<Bool, NetworkError> {
        let responseData = await apiService.callApiService(
            httpMethod: .POST,
            endPoint: AccountEndPoint.signIn.rawValue
        )
        let entityDataResult = ResultMapper<Bool>().toMap(responseData)
        
        switch entityDataResult {
        case .success:
            return .success(true)
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
}
