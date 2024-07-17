//
//  DummyClass.swift
//  Domain
//
//  Created by 김동준 on 7/11/24
//  Copyright © 2024 QCells. All rights reserved.
//

struct DummyClass {
    static let classList: [ClassInformation] = [
        ClassInformation(
            id: "1",
            className: "수학",
            studentName: "김철수",
            studentAge: "고2",
            days: ["수", "금"],
            time: 2,
            maxNumOfClass: 8,
            currentNumOfClass: 0
        )
    ]
    
    static let detailClass: ClassInformation = ClassInformation(
        id: "1",
        className: "수학",
        studentName: "김철수",
        studentAge: "고2",
        days: ["수", "금"],
        time: 2,
        maxNumOfClass: 8,
        currentNumOfClass: 0
    )
}
