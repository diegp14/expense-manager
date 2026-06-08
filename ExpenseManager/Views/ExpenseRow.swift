//
//  ExpenseRow.swift
//  Manager Expense
//
//  Created by Diego Guzman on 13/03/26.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: Expense
    var body: some View {
        HStack {
            let _  = print("date: \(expense.date)")
            ExpenseType(rawValue: expense.expanseType)?.icon
                .font(.title2)
                .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title)
                    .font(.body)
                    .fontWeight(.medium)
                
                HStack(spacing: 8 ) {
                    Text(ExpenseType(rawValue: expense.expanseType)?.title ?? "-")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    Text("•")
                        .foregroundStyle(.secondary)
                    Text(expense.date.formatted)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text("$\(expense.value.formatted(.currency(code: "es_MX")))")
                .font(.body)
                .fontWeight(.semibold)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let expense = Expense.sampleData[0]
    ExpenseRow(expense: expense)
}
