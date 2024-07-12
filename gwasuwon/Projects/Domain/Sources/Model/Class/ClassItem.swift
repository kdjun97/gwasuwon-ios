//
//  ClassItem.swift
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
