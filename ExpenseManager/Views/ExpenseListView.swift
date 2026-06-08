//
//  ExpenseListView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) private var modelContext
    var expenseType: ExpenseType? = nil
    
    @Query private var expenseItems: [Expense]
    
    let searchText: String
    var startDate: Date
    var endDate: Date
    
    init(expenseType: ExpenseType? = nil, searchText: String = "", startDate: Date, endDate: Date){
        self.searchText = searchText
        self.expenseType = expenseType
        let start = Calendar.current.startOfDay(for: startDate)
        self.startDate = start
        let end = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: endDate) ?? endDate
        self.endDate = end
        print("start date: \(start) - end date: \(end)")
        let predicate = #Predicate<Expense>{
            (expenseType == nil || $0.expanseType == expenseType!.rawValue) && (searchText.isEmpty || $0.title.localizedStandardContains(searchText)) && ( $0.date >= start && $0.date <= end )  }
        _expenseItems = Query(filter: predicate, sort: \.date, order: .reverse )
       
    }
    
    var body: some View {
        
        if expenseItems.isEmpty {
            EmptyStateView(hasFilters: !searchText.isEmpty || expenseType != nil || startDate != Calendar.current.startOfDay(for: .now) )
        }else{
            VStack{
                ExpenseInfoView(expenseCount: expenseItems.count, expenseTotal: expenseItems.reduce(0){ $0 + $1.value })
                    .padding(0)
                
                List {
                    ForEach(groupExpense(expenseItems), id: \.date){ group in
                        Section(header: headerDate(group.date)) {
                            ForEach(group.expense) { expense in
                                NavigationLink {
                                    AddExpenseView(expense: expense)
                                } label: {
                                    ExpenseRow(expense: expense)
                                }
                                .swipeActions {
                                    Button {
                                        modelContext.delete(expense)
                                    } label: {
                                        Text("Borrar")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        
                    }
//                    NavigationLink {
//                        EditExpenseView(expense: expense)
//                    } label: {
//                        ExpenseRow(expense: expense)
//                    }
//                        .swipeActions {
//                            Button {
//                                modelContext.delete(expense)
//                            } label: {
//                                Text("Eliminar")
//                            }
//                            .tint(.red)
//                        }
                    }
                }
            }
        }
    
    private func groupExpense(_ expenses: [Expense]) -> [(
        date: Date, expense: [Expense]
    )] {
        let calendar = Calendar.current
        let group = Dictionary(grouping: expenses) { expense in
            calendar.startOfDay(for: expense.date)
        }
        return group.map {
            (date: $0.key, expense: $0.value.sorted { $0.date > $1.date })
        }
        .sorted { $0.date > $1.date }
    }
    
    private func headerDate(_ fecha: Date) -> some View {
        let calendar = Calendar.current
        let hoy = calendar.startOfDay(for: Date())
        let ayer = calendar.date(byAdding: .day, value: -1, to: hoy)!

        let texto: String
        if calendar.isDate(fecha, inSameDayAs: hoy) {
            texto = "Hoy"
        } else if calendar.isDate(fecha, inSameDayAs: ayer) {
            texto = "Ayer"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "es_MX")
            formatter.dateFormat = "EEEE, d 'de' MMMM"
            texto = formatter.string(from: fecha).capitalized
        }
        return Text(texto)
            .font(.headline)
    }
    
    }

#Preview {
    ExpenseListView(expenseType: nil, startDate: .now, endDate: .now)
        .modelContainer(PreviewContainer.shared.modelContainer)
}

#Preview("Filter by Food Expense") {
    let expenseType: ExpenseType = .food
        
    ExpenseListView(expenseType: expenseType, startDate: .now, endDate: .now)
            .modelContainer(PreviewContainer.shared.modelContainer)
    }


#Preview("Empty View") {
    ExpenseListView(startDate: .now, endDate: .now)
}
