//
//  Date+Extension.swift
//  Util
//
//  Created by 김동준 on 7/21/24
//

import Foundation

extension Date {
    public func formattedString(format: String = DateFormatConstants.defaultFormat) -> String {
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = format
        let dateFormat = dateFormmatter.string(from: self)
        return dateFormat
    }
    
    public func toEpochMilliseconds() -> Int {
        let timeInterval = self.timeIntervalSince1970
        let epochMilliseconds = Int(timeInterval * 1000)
        
        return epochMilliseconds
    }
    
    public func formattedStringWithLocale(format: String, locale: String = "ko_KR") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.dateFormat = format
        let dateFormat = dateFormatter.string(from: self)
        return dateFormat
    }
}
