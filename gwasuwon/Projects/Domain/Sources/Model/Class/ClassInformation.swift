//
//  ClassInformation.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//

public struct ClassInformation: Hashable {
    public let className: String
    public let studentName: String
    public let studentAge: String
    public let days: [String]
    public let time: Int
    public let maxNumOfClass: Int
    public let currentNumOfClass: Int
}

public enum SubjectType: String, CaseIterable {
    case none = ""
    case math = "수학"
    case korean = "국어"
    case englsh = "영어"
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
    case mon = "월"
    case tue = "화"
    case wed = "수"
    case thu = "목"
    case fri = "금"
    case sat = "토"
    case sun = "일"
}

public enum ClassDelayCount: String, CaseIterable {
    case none = ""
    case one = "1회"
    case two = "2회"
}
