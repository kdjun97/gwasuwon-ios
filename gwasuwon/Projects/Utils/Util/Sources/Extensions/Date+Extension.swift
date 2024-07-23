//
//  Date+Extension.swift
//  Util
//
//  Created by 김동준 on 7/21/24
//

import Foundation

extension Date {
    public func formattedString(format: String) -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = format
        let dateFormat = dateFormmater.string(from: self)
        return dateFormat
    }
    
    public func toEpochMilliseconds() -> Int {
        let timeInterval = self.timeIntervalSince1970
        let epochMilliseconds = Int(timeInterval * 1000)
        
        return epochMilliseconds
    }
}
