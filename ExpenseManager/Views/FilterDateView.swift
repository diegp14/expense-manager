//
//  FilterDateView.swift
//  ExpenseManager
//
//  Created by Diego Guzman on 10/06/26.
//

import SwiftUI


enum DateOption {
    case today
    case oneWeekAgo
    case oneMonthAgo
    case currentMonth
    case custom
    
}

struct FilterDateView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Binding var showRangeDatePicker: Bool
    @Binding var selectedDateOption: DateOption
    
    var action: (_ option: DateOption ) -> Void = { _ in }
    
    var body: some View {
        NavigationStack {
            List {
                Button {
                    startDate = Date()
                    endDate = Date()
                    selectedDateOption = .today
                } label: {
                    HStack {
                        if   selectedDateOption == .today {
                            Image(systemName: "checkmark")
                        }
                        Text("Hoy")
                    }
                }
                Button {
                    startDate = Calendar.current.date(byAdding: .day, value: -7, to: .now) ?? .now
                    endDate = .now
                    selectedDateOption = .oneWeekAgo
                } label: {
                    HStack {
                        if selectedDateOption == .oneWeekAgo {
                            Image(systemName: "checkmark")
                        }
                        Text("Una semana atrás")
                    }
                }
                
                Button {
                    let calendar = Calendar.current
                    startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: Date())) ?? .now
                    endDate = Date()
                    selectedDateOption = .currentMonth
                } label: {
                    HStack {
                        if selectedDateOption == .currentMonth {
                            Image(systemName: "checkmark")
                        }
                        Text("Mes actual")
                    }
                }
                
                Button {
                    startDate = Calendar.current.date(byAdding: .month, value: -1, to: .now) ?? .now
                    endDate = .now
                    selectedDateOption = .oneMonthAgo
                } label: {
                    HStack {
                        if selectedDateOption == .oneMonthAgo {
                            Image(systemName: "checkmark")
                        }
                        Text("Un mes atrás")
                    }
                }
                Button {
                    showRangeDatePicker = true
                    selectedDateOption = .custom
                } label: {
                    HStack {
                        if selectedDateOption == .custom {
                            Image(systemName: "checkmark")
                        }
                        Text("Periodo personalizado")
                    }
                }
                
            }
            .navigationTitle("Fecha")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $showRangeDatePicker, destination: {
                RangeDatePicker(startDate: $startDate, endDate: $endDate)
            })
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("", systemImage: "xmark")
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("", systemImage: "checkmark")
                    }

                }
            }
        }
    }
}

//#Preview {
//    FilterDateView(startDate: <#Binding<Date>#>, endDate: <#Binding<Date>#>, showRangeDatePicker: <#Binding<Bool>#>)
//}
