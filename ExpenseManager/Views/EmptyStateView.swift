//
//  EmptyStateView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI

struct EmptyStateView: View {
    let hasFilters: Bool
    
    
    var body: some View {
        VStack(spacing: 16) {
                    Image(systemName: hasFilters ? "magnifyingglass" : "checkmark.circle")
                        .font(.system(size: 60))
                        .foregroundStyle(.secondary)
                    
                    Text(hasFilters ? "No se encontraron gastos" : "No hay gastos")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(hasFilters ? "Intenta con otros filtros" : "Agrega tu primer gasto")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(hasFilters: true)
}
