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
    private let validation: AddEditExpenseValidation = .shared
    
    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var selectExpenseType: ExpenseType = .food
    @State private var selectPaymentMethod: PaymentMethod = .cash
    @State private var selectPaymentType: PaymentType = .cash
    @State private var date: Date = Date()
    
   
    @State private var stateErrorDesc: InvalidReason? = nil
    @State private var stateErrorAmount: InvalidReason? = nil
    @State private var showAlert: Bool = false
    
    @FocusState private var focusField: FocusField?
    
    
    var expense: Expense? = nil
    
    var messageErrorDesc : String? {
        stateErrorDesc?.description
    }
    
    var messageErrorAmount: String? {
        stateErrorAmount?.description
    }
    
    var isEditing: Bool {
        expense != nil
    }
    
    var disabledPaymentMethod: Bool {
        selectPaymentType == .credit
    }
    
    var hasChanges: Bool {
        if isEditing {
            expense?.title != title || expense?.value != Double(amount) ?? 0
        } else {
            !title.isEmpty || !amount.isEmpty
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Descripción*", text: $title)
                    .textFieldStyle(.bottonMessage(message: messageErrorDesc, type: .error))
                    .focused($focusField, equals: .title)
                    .onChange(of: title) { oldValue, newValue in
                        stateErrorDesc = validation.validationDescription(newValue)
                    }
                    .onSubmit {
                        DispatchQueue.main.async {
                            focusField = .amount
                        }
                    }
                TextField("Monto*", text: $amount)
                    .textFieldStyle(.bottonMessage(message: messageErrorAmount, type: .error))
                    .keyboardType(.numbersAndPunctuation)
                    .onChange(of: amount) { oldValue, newValue in
                        stateErrorAmount = validation.validationAmount(String(newValue))
                    }
                Picker("Tipo de Gasto", selection: $selectExpenseType){
                    ForEach(ExpenseType.allCases){ option in
                        HStack {
                            option.icon
                            Text(option.title)
                        }
                        .tag(option)
                    }
                }
                
                Picker("Tipo de Pago", selection: $selectPaymentType) {
                    ForEach(PaymentType.allCases) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                .onChange(of: selectPaymentType) { oldValue, newValue in
                    if newValue ==  .credit {
                        selectPaymentMethod = .card
                    }
                }
                
                Picker("Método de Pago", selection: $selectPaymentMethod) {
                    ForEach(PaymentMethod.allCases) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                .disabled(disabledPaymentMethod)
                
                DatePicker("Fecha", selection: $date, in: ...date,  displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "es_MX"))
                    .environment(\.timeZone, TimeZone(identifier: "America/Mexico_City")!)
            }
            .navigationTitle(isEditing ? "Editar Gasto" : "Agregar Gasto")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(hasChanges)
            .task {
                if let expense = expense {
                    title = expense.title
                    amount = String(expense.value)
                    selectExpenseType = ExpenseType(rawValue: expense.expanseType) ?? ExpenseType.food
                    date = expense.date
                    selectPaymentMethod = PaymentMethod(rawValue: expense.paymentMethod) ?? .cash
                    selectPaymentType = PaymentType(rawValue: expense.paymentType) ?? .cash
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusField = .title
                }
            }
            .toolbar {
                if hasChanges {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            showAlert = true
                        } label: {
                            Image(systemName: "xmark")
                        }

                    }
                }
                
                ToolbarItem(placement: .primaryAction){
                    Button{
                     addExpense()
                    } label: {
                        Label("Guardar", systemImage: "checkmark")
                    }
                }
            }
            .alert("Salir sin guardar", isPresented: $showAlert) {
                Button("Cerrar", role: .destructive) {
                   dismiss()
                }
                Button("Cancelar", role: .cancel) {
                    // Triggers automatically to dismiss without action
                }
            } message: {
                Text("Al salir se perderán los datos escritos.")
            }

        }
    }
    
    private func addExpense() {
        guard validateFields() else { return }
        if isEditing {
            expense?.title = title
            expense?.value = Double(amount) ?? 0.0
            expense?.date = date
            expense?.expanseType = selectExpenseType.rawValue
            expense?.paymentMethod = selectPaymentMethod.rawValue
            expense?.paymentType = selectPaymentType.rawValue
        } else {
            let newExpense = Expense(title: title,
                                     value: Double(amount) ?? 0.0,
                                     date: date,
                                     expanseType: selectExpenseType,
                                     paymentMethod: selectPaymentMethod,
                                     paymentType: selectPaymentType
            )
            modelContext.insert(newExpense)
        }
        do {
            try modelContext.save()
        } catch {
            print("Error al guardar el registro\(error)")
        }
        dismiss()
 
    }
    
    private func validateFields() -> Bool {
        stateErrorDesc =  validation.validationDescription(title)
        stateErrorAmount = validation.validationAmount(amount)
        return stateErrorDesc == nil && stateErrorAmount == nil
    }
}

#Preview {
    AddExpenseView()
}

#Preview("Edit View") {
    AddExpenseView(expense: Expense.sampleData.first )
}
