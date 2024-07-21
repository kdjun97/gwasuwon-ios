//
//  ClassMapper.swift
//  Data
//
//  Created by 김동준 on 7/21/24
//

import Domain

class ClassMapper {
    static func toClassInformationList(response: ClassListResponse) -> ClassInformation {
        return ClassInformation(
            classCount: response.numberOfElements,
            classInformationItems: response.content.map { item in
                ClassInformationItem(
                    id: item.id,
                    subject: item.subject,
                    studentName: item.studentName,
                    grade: item.grade,
                    days: item.classDays,
                    sessionDuration: "",// item.sessionDuration,
                    maxNumOfClass: item.numberOfSessions,
                    currentNumOfClass: item.numberOfSessionsCompleted
                )
                
            }
        )
    }
}
