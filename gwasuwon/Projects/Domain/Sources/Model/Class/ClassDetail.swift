//
//  ClassDetail.swift
//  Domain
//
//  Created by 김동준 on 7/24/24
//

public struct ClassDetail: Equatable {
    public let id: Int
    public let studentName: String
    public let rescheduleCount: Int
    public let hasStudent: Bool
    public let schedules: [ClassSchedule]
    
    public init(
        id: Int,
        studentName: String,
        rescheduleCount: Int,
        hasStudent: Bool,
        schedules: [ClassSchedule]
    ) {
        self.id = id
        self.studentName = studentName
        self.rescheduleCount = rescheduleCount
        self.hasStudent = hasStudent
        self.schedules = schedules
    }
}

public struct ClassSchedule: Equatable {
    public let id: Int
    public let date: Int
    public let status: ClassScheduleStatus
    
    public init(
        id: Int,
        date: Int,
        status: ClassScheduleStatus
    ) {
        self.id = id
        self.date = date
        self.status = status
    }
}

public enum ClassScheduleStatus: String {
    case scheduled = "SCHEDULED"
    case completed = "COMPLETED"
    case canceled = "CANCELED"
}
