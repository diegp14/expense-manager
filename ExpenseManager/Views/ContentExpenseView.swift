//
//  ContentExpenseView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 13/03/26.
//

import SwiftData
import SwiftUI

struct ContentExpenseView: View {

    @State private var selectedExpanseType: ExpenseType? = nil
    @State private var showNewExpense: Bool = false
    @State private var searchText: String = ""
    @State private var startDate: Date =
        Calendar.current.date(byAdding: .day, value: -6, to: .now) ?? .now
    @State private var endDate: Date = .now
    @State private var showDatePicker: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Button {
                    showDatePicker = true
                } label: {
                    VStack {
                        HStack {
                            Label("", systemImage: "calendar")
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Fecha")
                                    .font(.callout)
                                HStack {
                                    Text(
                                        startDate.formatted(
                                            date: .abbreviated,
                                            time: .omitted
                                        )
                                    )
                                    .font(.callout)
                                    Text("-")
                                    Text(
                                        endDate.formatted(
                                            date: .abbreviated,
                                            time: .omitted
                                        )
                                    )
                                    .font(.callout)
                                }
                            }
                        }
                        .padding(.leading, 10)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        .foreground.opacity(0.05),
                        in: RoundedRectangle(cornerRadius: 10)
                    )
                }
                .buttonStyle(.plain)
                .popover(isPresented: $showDatePicker) {
                    NavigationStack {
                        RangeDatePicker(startDate: $startDate, endDate: $endDate)
                            .presentationCompactAdaptation(.popover)
                            .frame(width: 350, height: 400)
                    }
                    
                }
            }
            Divider()
            ExpenseListView(
                expenseType: selectedExpanseType,
                searchText: searchText,
                startDate: startDate,
                endDate: endDate
            )
            .navigationTitle(Text("Gastos"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Tipo de gasto", selection: $selectedExpanseType)
                        {
                            Text("Todos").tag(nil as ExpenseType?)
                            ForEach(ExpenseType.allCases) { expenseType in
                                HStack {
                                    expenseType.icon
                                    Text(expenseType.title)
                                }
                                .tag(expenseType)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .overlay(alignment: .topTrailing) {
                                if selectedExpanseType != nil {
                                    Group {
                                        Text("1")
                                            .font(.caption)
                                            .foregroundStyle(.white)
                                            .padding(5)
                                            .background(Circle().fill(.red))
                                            .offset(x: 7, y: -10) 
                                        
                                    }
                                }
                            }
                    }
                }

                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showNewExpense.toggle()
                    } label: {
                        Label("Agregar Gasto", systemImage: "plus")
                    }
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Buscar Gastos"
            )
        }
        .sheet(isPresented: $showNewExpense) {
            AddExpenseView()
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    ContentExpenseView()
        .modelContainer(PreviewContainer.shared.modelContainer)
}
