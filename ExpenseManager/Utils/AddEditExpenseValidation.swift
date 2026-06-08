//
//  AddEditExpenseValidation.swift
//  ExpenseManager
//
//  Created by Diego Guzman on 24/05/26.
//

import Foundation


class AddEditExpenseValidation {
    
    private let maxChars = 50
    private let minChars: Int = 3
    private let decimalPlaces: Int = 2
    private let minAmount: Double = 0.01
    private let maxAmount: Double = 100_000_000.00
    static let shared = AddEditExpenseValidation()
    private let regexAmount = /^\d*\.?\d+$/

    
    private init() {
        
    }
    
    func validationDescription(_ description: String) -> InvalidReason? {
        var invalid: InvalidReason? = nil
        if description.isEmpty {
            invalid = .empty
        }else if description.contains(where: { !$0.isLetter && !$0.isWhitespace }) {
            invalid = .invalidFormat
        }else if description.count < minChars {
            invalid = .tooShort(minChars)
        }
        else if description.count > maxChars {
            invalid = .tooLong(maxChars)
        }
        return invalid
    }
    
    func validationAmount(_ amount: String) -> InvalidReason? {
        var invalid: InvalidReason? = nil
        if amount.isEmpty {
            invalid = .empty
        }else if amount.wholeMatch(of: regexAmount) == nil {
            invalid = .invalidFormat
        }else if let amountDouble = Double(amount), amountDouble.isInfinite {
            invalid = .invalidFormat
        }else if let amountDouble = Double(amount), amountDouble < minAmount {
            invalid = .tooShortValue(minAmount)
        }else if let amountDouble = Double(amount), amountDouble > maxAmount {
            invalid = .tooLongValue(maxAmount)
        }
        return invalid
    }
}
