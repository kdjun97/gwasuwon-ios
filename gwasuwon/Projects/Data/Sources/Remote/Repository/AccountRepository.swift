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
    
    public func postSignIn(provider: String, thirdPartyAccessToken: String) async -> Result<SignInResult, NetworkError> {
        let responseData = await apiService.callApiService(
            httpMethod: .POST,
            endPoint: AccountEndPoint.signIn(provider).url,
            body: SignInRequest(accessToken: thirdPartyAccessToken)
        )
        let entityDataResult = ResultMapper<SignInResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            return .success(AuthMapper.toSignInResult(response: response))
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
}
