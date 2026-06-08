//
//  ChartExample.swift
//  ExpenseManager
//
//  Created by Diego Guzman on 20/03/26.
//

import SwiftUI
import Charts

struct BarChartWithHover: View {
    let data = [
        ("Ene", 120), ("Feb", 85), ("Mar", 150),
        ("Abr", 200), ("May", 95), ("Jun", 175)
    ]
    
    @State private var selectedMonth: String? = nil
    @State private var selectedValue: Int? = nil
    @State private var tooltipPosition: CGPoint = .zero

    var body: some View {
        ZStack(alignment: .topLeading) {
            Chart {
                ForEach(data, id: \.0) { item in
                    BarMark(
                        x: .value("Mes", item.0),
                        y: .value("Ventas", item.1)
                    )
                    .foregroundStyle(
                        item.0 == selectedMonth
                            ? Color.blue
                            : Color.blue.opacity(0.4)
                    )
                    // Animación de escala en la barra seleccionada
                    .annotation(position: .top) {
                        if item.0 == selectedMonth {
                            Text("\(item.1)")
                                .font(.caption.bold())
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .chartOverlay { proxy in
                GeometryReader { geo in
                    Rectangle()
                        .fill(Color.clear)
                        .contentShape(Rectangle())
                        // Hover simulado con DragGesture (funciona en iOS 16)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    updateSelection(
                                        at: value.location,
                                        proxy: proxy,
                                        geometry: geo
                                    )
                                    tooltipPosition = value.location
                                }
                                .onEnded { _ in
                                    selectedMonth = nil
                                    selectedValue = nil
                                }
                        )
                }
            }
            .frame(height: 250)
            .padding()

            // Tooltip flotante
            if let month = selectedMonth, let value = selectedValue {
                TooltipView(month: month, value: value)
                    .position(
                        x: min(max(tooltipPosition.x, 60), UIScreen.main.bounds.width - 60),
                        y: tooltipPosition.y - 50
                    )
            }
        }
    }

    // MARK: - Lógica de selección
    private func updateSelection(
        at location: CGPoint,
        proxy: ChartProxy,
        geometry: GeometryProxy
    ) {
        // Convierte la posición del toque a un valor del eje X
        let relativeX = location.x - geometry[proxy.plotFrame!].origin.x

        if let month: String = proxy.value(atX: relativeX) {
            if let match = data.first(where: { $0.0 == month }) {
                selectedMonth = match.0
                selectedValue = match.1
            }
        }
    }
}

// MARK: - Tooltip
struct TooltipView: View {
    let month: String
    let value: Int

    var body: some View {
        VStack(spacing: 4) {
            Text(month)
                .font(.caption)
                .foregroundColor(.secondary)
            Text("\(value)")
                .font(.headline.bold())
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.15), radius: 6, y: 3)
        )
    }
}


#Preview {
    BarChartWithHover()
}
