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
    
    public func postCreateClass(
        _ studentName: String,
        _ grade: String,
        _ memo: String,
        _ subject: SubjectType,
        _ sessionDuration: SessionDurationType,
        _ classDays: [String],
        _ numberOfSessions: Int,
        _ startDate: Int,
        _ rescheduleCount: Int
    ) async -> Result<Int, NetworkError> {
        let createClassRequest = CreateClassRequest(
            studentName: studentName,
            grade: grade,
            memo: memo,
            subject: subject.rawValue,
            sessionDuration: sessionDuration.rawValue,
            classDays: classDays,
            numberOfSessions: numberOfSessions,
            startDate: startDate,
            rescheduleCount: rescheduleCount
        )
        
        let responseData = await apiService.callApiService(
            httpMethod: .POST,
            endPoint: ClassEndPoint.classList.url,
            body: createClassRequest
        )
        let entityDataResult = ResultMapper<CreateClassResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            return .success(response.id)
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
}
