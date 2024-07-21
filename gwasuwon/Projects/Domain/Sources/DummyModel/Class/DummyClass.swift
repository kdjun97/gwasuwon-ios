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
            subject: "수학",
            studentName: "김한동",
            grade: "고1",
            days: ["월", "수", "금"],
            sessionDuration: "PT1H30M",
            maxNumOfClass: 8,
            currentNumOfClass: 1)
        ])
    ]
    
    static let detailClass: ClassInformation = ClassInformation(classCount: 1, classInformationItems: [.init(
        id: 1,
        subject: "수학",
        studentName: "김한동",
        grade: "고1",
        days: ["월", "수", "금"],
        sessionDuration: "PT1H30M",
        maxNumOfClass: 8,
        currentNumOfClass: 1)
    ])
}
