//
//  ClassListResponse.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

struct ClassListResponse : Decodable {
    let content: [ClassResponse]
    let numberOfElements: Int
}

struct ClassResponse: Decodable {
    let id: Int
    let studentName: String
    let grade: String
    let subject: String
    let sessionDuration: String
    let classDays: [String]
    let numberOfSessionsCompleted: Int
    let numberOfSessions: Int
}

struct CreateClassResponse: Decodable {
    let id: Int
    let studentName: String
    let grade: String
    let subject: String
    let sessionDuration: String
    let classDays: [String]
    let numberOfSessionsCompleted: Int
    let startDate: Int
    let numberOfSessions: Int
}
