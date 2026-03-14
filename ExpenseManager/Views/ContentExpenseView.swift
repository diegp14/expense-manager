//
//  ContentExpenseView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 13/03/26.
//

import SwiftUI
import SwiftData

struct ContentExpenseView: View {
    
    @State private var selectedExpanseType: ExpenseType? = nil
    @State private var showNewExpense: Bool = false
    @State private var searchText: String = ""
    @State private var date: Date = Date()
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Text("Tipo de Gasto:")
                    Spacer()
                    Picker("Tipo de gasto", selection: $selectedExpanseType){
                        Text("Todos").tag(nil as ExpenseType?)
                        ForEach(ExpenseType.allCases){ expenseType in
                            HStack {
                                expenseType.icon
                                Text(expenseType.title)
                            }
                            .tag(expenseType)
                        }
                    }
                    .tint(.black)
                    .pickerStyle(.menu)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            }
            Divider()
            ExpenseListView(expenseType: selectedExpanseType, searchText: searchText)
                .navigationTitle(Text("Gastos"))
                .toolbar {
                    ToolbarItem(placement: .primaryAction)
                    {
                        Button("Agregar Gasto"){
                            showNewExpense.toggle()
                        }
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always) ,prompt: "Buscar Gastos")
        }
        .sheet(isPresented: $showNewExpense){
            AddExpenseView()
        }
    }
}

#Preview {
    ContentExpenseView()
        .modelContainer(PreviewContainer.shared.modelContainer)
}
