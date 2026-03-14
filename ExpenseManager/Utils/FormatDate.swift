//
//  FormatDate.swift
//  Manager Expense
//
//  Created by Diego Guzman on 13/03/26.
//

import Foundation

public extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
