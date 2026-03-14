//
//  Expense.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Expense {
    var id: UUID
    var title: String
    var value: Double
    var date: Date
    var expanseType: Int
    
    init( title: String, value: Double, date: Date = Date(), expanseType: ExpenseType) {
        self.id = UUID()
        self.title = title
        self.value = value
        self.date = date
        self.expanseType = expanseType.rawValue
    }
}

enum ExpenseType: Int, Codable, CaseIterable, Identifiable {
    case food
    case transport
    case entertainment
    case clothes
    case health
    case other
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .food: return "Alimentación"
        case .clothes: return "Ropa"
        case .entertainment: return "Entretenimiento"
        case .transport: return "Transporte"
        case .health: return "Salud"
        case .other: return "Otros"
        }
    }
    
    var icon: Image {
        switch self {
        case .food: return Image(systemName:"fork.knife")
        case .clothes: return Image(systemName: "hanger")
        case .entertainment: return Image(systemName: "film")
        case .transport: return Image(systemName:"car")
        case .health: return Image(systemName: "apple.meditate")
        case .other: return Image(systemName: "banknote")
        }
    }
}
