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
//        KeyChainStorage.delete(key: KeyStorageKeys.CLASS_ID)
//        
        switch entityDataResult {
        case let .success(response):
            KeyChainStorage.save(key: KeyStorageKeys.ACCESS_TOKEN, data: response.accessToken)
            KeyChainStorage.save(key: KeyStorageKeys.REFRESH_TOKEN, data: response.refreshToken)
            return .success(AuthMapper.toSignInResult(response: response))
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
    
    public func postSignUp(accessToken: String, type: String) async -> Result<SignUpResult, NetworkError> {
        KeyChainStorage.save(key: KeyStorageKeys.ACCESS_TOKEN, data: accessToken)
        let responseData = await apiService.callApiService(
            httpMethod: .POST,
            endPoint: AccountEndPoint.signUp.url,
            body: SignUpRequest(
                privacyPolicyAgreement: true,
                termsOfServiceAgreement: true,
                role: type
            )
        )

        let entityDataResult = ResultMapper<SignUpResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            return .success(AuthMapper.toSignUpResult(response: response))
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
}
