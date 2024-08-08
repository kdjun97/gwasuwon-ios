//
//  ClassDetailResponse.swift
//  Data
//
//  Created by 김동준 on 7/24/24
//

struct ClassDetailResponse: Decodable {
    let id: Int
    let studentName: String
    let grade: String
    let memo: String
    let subject: String
    let sessionDuration: String
    let classDays: [String]
    let numberOfSessions: Int
    let startDate: Int
    let rescheduleCount: Int
    let hasStudent: Bool
    let schedules: [ClassScheduleResponse]
}

struct ClassScheduleResponse: Decodable {
    let id: Int
    let date: Int
    let status: String
}
