//
//  DummyClass.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//  Copyright © 2024 QCells. All rights reserved.
//

struct DummyClass {
    static let classList: [ClassInformation] = [
        .init(classCount: 1, classInformationItems: [.init(
            id: 1,
            subject: .math,
            studentName: "김한동",
            grade: "고1",
            days: [.mon, .wed, .fri],
            sessionDuration: .oneHalf,
            numberOfSessions: 8,
            currentNumOfClass: 1)
        ])
    ]
    
    static let detailClass: ClassInformation = ClassInformation(classCount: 1, classInformationItems: [.init(
        id: 1,
        subject: .math,
        studentName: "김한동",
        grade: "고1",
        days: [.mon, .wed, .fri],
        sessionDuration: .oneHalf,
        numberOfSessions: 8,
        currentNumOfClass: 1)
    ])
}
