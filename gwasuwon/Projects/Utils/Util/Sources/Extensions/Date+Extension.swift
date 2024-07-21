//
//  Date+Extension.swift
//  Util
//
//  Created by 김동준 on 7/21/24
//

import Foundation

extension Date {
    public func formattedString() -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = DateFormatConstants.defaultFormat
        let dateFormat = dateFormmater.string(from: self)
        return dateFormat
    }
}
