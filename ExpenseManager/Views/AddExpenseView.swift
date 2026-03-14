//
//  AddExpenseView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var amount: Double?
    @State private var selectExpenseType: ExpenseType = .food
    @State private var date: Date = Date()
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Titulo del gasto", text: $title)
                TextField("Monto", value: $amount, formatter: NumberFormatter())
                Picker("Tipo de Gasto", selection: $selectExpenseType){
                    ForEach(ExpenseType.allCases){ option in
                        HStack {
                            option.icon
                            Text(option.title)
                        }
                        .tag(option)
                    }
                }
                DatePicker("Fecha", selection: $date, in: ...date,  displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "es_MX"))
                    .environment(\.timeZone, TimeZone(identifier: "America/Mexico_City")!)
            }
            .navigationTitle("Agregar Gasto")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button{
                        let newExpense = Expense(title: title,
                                                 value: amount ?? 0.0,
                                                 date: date,
                                                 expanseType: selectExpenseType)
                        modelContext.insert(newExpense)
                        do {
                            try modelContext.save()
                        } catch {
                            print("\(error)")
                        }
                        dismiss()
                    } label: {
                        Text("Guardar")
                    }
                    .disabled(title.isEmpty || amount == nil)
                }
                ToolbarItem(placement: .cancellationAction){
                    Button{
                        dismiss()
                    } label: {
                        Text("Cancelar").foregroundStyle(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpenseView()
}
