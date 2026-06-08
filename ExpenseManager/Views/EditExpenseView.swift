//
//  EditExpenseView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 13/03/26.
//

import SwiftUI
import SwiftData

struct EditExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    
    let expense: Expense
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var date: Date = Date()
    @State private var type: ExpenseType = .food
    
    
    var changed: Bool {
        title != expense.title ||
        amount != String(expense.value) ||
        date != expense.date ||
        type != ExpenseType(rawValue: expense.expanseType)
    }
    
    var errorAmount: String? {
        if amount.isEmpty {
            return "El campo no puede estar vacio"
        } else if amount.contains(where: { $0.isLetter }) {
            return "Solo se permiten numeros"
        }
        else {
            return nil
        }
    }
    
    var errorTitle: String? {
        if title.isEmpty {
            return "El titulo no puede estar vacio"
        }else {
            return nil
        }
    }
    

    
    var body: some View {
        NavigationStack {
            Form {
//                TextField("Titulo del gasto", text: $title)
                ValidateTextField(title: "Nombre del gasto", text: $title, errorMessage: errorTitle)
                ValidateTextField(title: "Monto", text: $amount, errorMessage: errorAmount)
                    .keyboardType(.decimalPad)
    
                Picker("Tipo de Gasto", selection: $type){
                    ForEach(ExpenseType.allCases){ option in
                        HStack {
                            option.icon
                            Text(option.title)
                        }
                        .tag(option)
                    }
                }
                DatePicker("Fecha", selection: $date, in: ...Date(),  displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "es_MX"))
                    .environment(\.timeZone, TimeZone(identifier: "America/Mexico_City")!)
            }
            .navigationTitle("Editar Gasto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        expense.title = title
                        expense.value = Double(amount) ?? 0.0
                        expense.expanseType = type.rawValue
                        expense.date = date
                        dismiss()
                    } label: {
                        Text("Guardar")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!changed || title.isEmpty || errorAmount != nil )

                }
            }
            .onAppear {
                title = expense.title
                amount = String(expense.value)
                date = expense.date
                if let typeRawValue = ExpenseType(rawValue: expense.expanseType) {
                    type = typeRawValue
                }
            }
            
        }
    }
}

#Preview {
    let preview = PreviewContainer.shared
    let expense = Expense.sampleData[1]
    EditExpenseView(expense: expense)
        .modelContainer(preview.modelContainer)
}
