//
//  ClassInformation.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

public struct ClassInformation: Hashable {
    public let classCount: Int
    public let classInformationItems: [ClassInformationItem]
    
    public init(
        classCount: Int,
        classInformationItems: [ClassInformationItem]
    ) {
        self.classCount = classCount
        self.classInformationItems = classInformationItems
    }
}

public struct ClassInformationItem: Hashable {
    public let id: Int
    public let subject: SubjectType
    public let studentName: String
    public let grade: String
    public let days: [ClassDayType]
    public let sessionDuration: SessionDurationType
    public let maxNumOfClass: Int
    public let currentNumOfClass: Int
    
    public init(
        id: Int,
        subject: SubjectType,
        studentName: String,
        grade: String,
        days: [ClassDayType],
        sessionDuration: SessionDurationType,
        maxNumOfClass: Int,
        currentNumOfClass: Int
    ) {
        self.id = id
        self.subject = subject
        self.studentName = studentName
        self.grade = grade
        self.days = days
        self.sessionDuration = sessionDuration
        self.maxNumOfClass = maxNumOfClass
        self.currentNumOfClass = currentNumOfClass
    }
}

public enum SubjectType: String, CaseIterable {
    case none = ""
    case korean = "KOREAN"
    case math = "MATHEMATICS"
    case englsh = "ENGLISH"
    case science = "SCIENCE"
    case social = "SOCIAL"
    
    public var name: String {
        switch self {
        case .none: ""
        case .math: "수학"
        case .korean: "국어"
        case .englsh: "영어"
        case .science: "과학"
        case .social: "사회"
        }
    }
}

public enum ClassTimeType: String, CaseIterable {
    case none = ""
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
}

public enum ClassDayType: String, CaseIterable {
    case mon = "MONDAY"
    case tue = "TUESDAY"
    case wed = "WEDNESDAY"
    case thu = "THURSDAY"
    case fri = "FRIDAY"
    case sat = "SATURDAY"
    case sun = "SUNDAY"
    
    public var name: String {
        switch self {
        case .mon: "월"
        case .tue: "화"
        case .wed: "수"
        case .thu: "목"
        case .fri: "금"
        case .sat: "토"
        case .sun: "일"
        }
    }
}

public enum SessionDurationType: String {
    case one = "PT1H"
    case oneHalf = "PT1H30M"
    case two = "PT2H"
    case twoHalf = "PT2H30M"
    case three = "PT3H"
    
    public var convertISO8601TimeToString: String {
        switch self {
        case .one: "1시간"
        case .oneHalf: "1시간30분"
        case .two: "2시간"
        case .twoHalf: "2시간30분"
        case .three: "3시간"
        }
    }
}

public enum ClassDelayCount: String, CaseIterable {
    case none = ""
    case one = "1회"
    case two = "2회"
}
