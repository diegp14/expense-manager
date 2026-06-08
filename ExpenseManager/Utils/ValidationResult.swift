//
//  ValidationResult.swift
//  ExpenseManager
//
//  Created by Diego Guzman on 24/05/26.
//

import Foundation


enum ValidationResult {
    case valid
    case invalid(InvalidReason)
}


enum InvalidReason: Equatable {
    case empty
    case invalidFormat
    case tooLong(Int)
    case tooShort(Int)
    case tooShortValue(Double)
    case tooLongValue(Double)
   
    var description: String {
        switch self {
        case .empty: return "El campo es requerido"
        case .invalidFormat: return "Formato inválido"
        case .tooLong(let maxCharacters): return "Maximo \(maxCharacters) caracteres"
        case .tooShort(let minCharacters): return "Minimo \(minCharacters) caracteres"
        case .tooLongValue(let maxValue): return "El valor debe ser menor a \(maxValue)"
        case .tooShortValue(let minValue): return "El valor debe ser mayor a \(minValue)"
        }
    }
}
