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
    var paymentMethod: Int
    var paymentType: Int
    
    init( title: String,
          value: Double,
          date: Date = Date(),
          expanseType: ExpenseType,
          paymentMethod: PaymentMethod,
          paymentType: PaymentType
    ) {
        self.id = UUID()
        self.title = title
        self.value = value
        self.date = date
        self.expanseType = expanseType.rawValue
        self.paymentMethod = paymentMethod.rawValue
        self.paymentType = paymentType.rawValue
    }
}

extension Expense {
    var paymentMethodWrapper: PaymentMethod {
        get { PaymentMethod(rawValue: paymentMethod) ?? .cash }
        set { paymentMethod = newValue.rawValue }
    }
    
    var paymentTypeWrapper: PaymentType {
        get { PaymentType(rawValue: paymentType) ?? .cash }
        set { paymentType = newValue.rawValue }
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

enum PaymentMethod: Int, Codable, CaseIterable, Identifiable {
    case cash = 0
    case card = 1
    case transfer = 2
    
    var name: String {
        switch self {
        case .cash: return "Efectivo"
        case .card: return "Tarjeta"
        case .transfer: return "Transferencia"
        }
    }
    var id: Self { self }
}

enum PaymentType: Int, Codable, CaseIterable, Identifiable {
    case cash = 0
    case credit = 1
    
    var name: String {
        switch self {
        case .cash: return "Contado"
        case .credit: return "Crédito"
        }
    }
    var id: Self { self }
}
