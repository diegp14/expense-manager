//
//  ExpenseInfoView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI

struct ExpenseInfoView: View {
    
    let expenseCount: Int
    let expenseTotal: Double
    
    var body: some View {
        VStack{
            HStack{
                Text("Cantidad de gastos:")
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(expenseCount)")
                    .font(.headline)
            }
                        
            HStack {
                Text("Total de gastos:")
                    .foregroundColor(.secondary)
                Spacer()
                Text(expenseTotal.formatted(.currency(code: "MXN")))
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
    }
}

#Preview {
    let expenseCount = Expense.sampleData.count
    let expenseTotal = Expense.sampleData.reduce(0) { $0 + $1.value }
    ExpenseInfoView(expenseCount: expenseCount, expenseTotal: expenseTotal)
}
