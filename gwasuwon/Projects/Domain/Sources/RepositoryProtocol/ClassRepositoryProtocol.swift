//
//  ClassRepositoryProtocol.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

public protocol ClassRepositoryProtocol {
    func getClassList() async -> Result<ClassInformation, NetworkError>
    func getDetailClass(id: String) async -> Result<ClassDetail, NetworkError>
    func postCreateClass(
        _ studentName: String,
        _ grade: String,
        _ memo: String,
        _ subject: SubjectType,
        _ sessionDuration: SessionDurationType,
        _ classDays: [String],
        _ numberOfSessions: Int,
        _ startDate: Int,
        _ rescheduleCount: Int
    ) async -> Result<Int, NetworkError>
    func postJoinClass(classId: String) async -> Result<Int, NetworkError>
}
