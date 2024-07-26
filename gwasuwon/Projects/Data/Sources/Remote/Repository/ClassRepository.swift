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
    
    public func getDetailClass(id: String) async -> Result<ClassDetail, NetworkError> {
        let responseData = await apiService.callApiService(
            httpMethod: .GET,
            endPoint: ClassEndPoint.classDetail(id).url
        )
        let entityDataResult = ResultMapper<ClassDetailResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            return .success(ClassMapper.toClassDetail(response: response))
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
    
    public func getDetailClass() async -> Result<ClassDetail, NetworkError> {
        let classId: String = KeyChainStorage.read(key: KeyStorageKeys.CLASS_ID) ?? ""

        let responseData = await apiService.callApiService(
            httpMethod: .GET,
            endPoint: ClassEndPoint.classDetail(classId).url
        )
        let entityDataResult = ResultMapper<ClassDetailResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            return .success(ClassMapper.toClassDetail(response: response))
        case let .failure(errorCase):
            return .failure(errorCase)
        }
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
    
    public func postJoinClass(classId: String) async -> Result<Int, NetworkError> {
        let responseData = await apiService.callApiService(
            httpMethod: .POST,
            endPoint: ClassEndPoint.classJoin.url,
            body: ClassJoinRequest(classId: Int(classId) ?? -1)
        )
        let entityDataResult = ResultMapper<ClassJoinResponse>().toMap(responseData)
        
        switch entityDataResult {
        case let .success(response):
            KeyChainStorage.save(key: KeyStorageKeys.CLASS_ID, data: classId)
            return .success(response.id)
        case let .failure(errorCase):
            return .failure(errorCase)
        }
    }
}
