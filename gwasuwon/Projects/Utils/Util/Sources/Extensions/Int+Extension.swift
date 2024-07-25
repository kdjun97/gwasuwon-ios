//
//  Int+Extension.swift
//  Util
//
//  Created by 김동준 on 7/24/24
//

import Foundation

extension Int {
    public func toDateFromIntEpochMilliseconds() -> Date {
        let epochSeconds = TimeInterval(self) / 1000

        let date = Date(timeIntervalSince1970: epochSeconds)
        
        return date
    }
}
