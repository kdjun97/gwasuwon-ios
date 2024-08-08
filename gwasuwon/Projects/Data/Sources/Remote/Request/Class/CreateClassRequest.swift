//
//  CreateClassRequest.swift
//  Data
//
//  Created by 김동준 on 7/23/24
//

struct CreateClassRequest: Encodable {
    let studentName: String
    let grade: String
    let memo: String
    let subject: String
    let sessionDuration: String
    let classDays: [String]
    let numberOfSessions: Int
    let startDate: Int
    let rescheduleCount: Int
}
