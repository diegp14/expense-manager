//
//  ExpanseSampleData.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import Foundation


extension Expense {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())!
    static let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
    
    static let sampleData: [Expense] = [
        Expense(title: "Cine", value: 240.0, date: lastWeek, expanseType: .entertainment),
        Expense(title: "Gasolina Carro", value: 500.0, date: lastMonth, expanseType: .transport),
        Expense(title: "Tenis", value: 1700.0, expanseType: .clothes),
        Expense(title: "Netflix", value: 140.0, date: threeDaysAgo, expanseType: .entertainment),
        Expense(title: "Desayuno", value: 69.0, expanseType: .food),
        Expense(title: "Compra de Mouse", value: 2009.0, date: lastWeek, expanseType: .other)
        ]
}
