//
//  Number+Extension.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public extension Int {
    var toDouble: Double {
        return Double(self)
    }

    var toString: String {
        return String(self)
    }

    var toCGFloat: CGFloat {
        return CGFloat(integerLiteral: self)
    }

    var toTimeStr: String {
        let s = self
        let date = Date(timeIntervalSince1970: Double(s) / 1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH mm ss SSS"
        return formatter.string(from: date)
    }
}

extension Double {
    /// To String
    var toString: String {
        return NSString(format: "%.3f", self) as String
    }

    /// To Int
    var toInt: Int {
        return Int(self)
    }
}
