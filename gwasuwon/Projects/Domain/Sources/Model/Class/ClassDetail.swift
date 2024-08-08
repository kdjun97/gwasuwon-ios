//
//  ClassDetail.swift
//  Domain
//
//  Created by 김동준 on 7/24/24
//

public struct ClassDetail: Equatable {
    public let id: Int
    public let studentName: String
    public let grade: String
    public let memo: String
    public let subject: SubjectType
    public let sessionDuration: SessionDurationType
    public let classDays: [ClassDayType]
    public let numberOfSessions: Int
    public let startDate: Int
    public let rescheduleCount: RescheduleCountType
    public let hasStudent: Bool
    public let schedules: [ClassSchedule]
    
    public init(
        id: Int,
        studentName: String,
        grade: String,
        memo: String,
        subject: SubjectType,
        sessionDuration: SessionDurationType,
        classDays: [ClassDayType],
        numberOfSessions: Int,
        startDate: Int,
        rescheduleCount: RescheduleCountType,
        hasStudent: Bool,
        schedules: [ClassSchedule]
    ) {
        self.id = id
        self.studentName = studentName
        self.grade = grade
        self.memo = memo
        self.subject = subject
        self.sessionDuration = sessionDuration
        self.classDays = classDays
        self.numberOfSessions = numberOfSessions
        self.startDate = startDate
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

public struct ClassProgressDay: Hashable {
    public let classDay: ClassDayType
    public var isSelected: Bool
    
    public init(classDay: ClassDayType, isSelected: Bool) {
        self.classDay = classDay
        self.isSelected = isSelected
    }
}
