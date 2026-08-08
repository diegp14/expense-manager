//
//  RangeDatePicker.swift
//  ExpenseManager
//
//  Created by Diego Guzman on 24/05/26.
//

import SwiftUI

struct RangeDatePicker: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var startDate: Date
    @Binding var endDate: Date
    @State private var picked = 0
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Picker("", selection: $picked) {
                    Text(startDate.formatted(date: .abbreviated, time: .omitted))
                        .tag(0)
                    Text(endDate.formatted(date: .abbreviated, time: .omitted))
                        .tag(1)
                }
                .pickerStyle(.segmented)
                
                if picked == 0 {
                    DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                        EmptyView()
                    }
                    .datePickerStyle(.graphical)
                    .onChange(of: startDate) { oldValue, newValue in
                        picked = 1
                    }
                }else {
                    DatePicker(selection: $endDate, in: startDate...Date(),  displayedComponents: .date) {
                        EmptyView()
                    }
                    .datePickerStyle(.graphical)
                }
            }
            .navigationTitle("Rango de fechas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Aceptar", systemImage: "checkmark")
                    }
                }
            }

        }

    }
}

#Preview {
    @Previewable @State var starDate = Date()
    @Previewable @State var endDate: Date = Date()
    NavigationStack {
        RangeDatePicker(startDate: $starDate, endDate: $endDate)
    }
}
