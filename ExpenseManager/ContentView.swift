//
//  ContentView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ContentExpenseView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
                .tag(0)
            ComingSoonView(icon: "chart.pie.fill", title: "Estadisticas en desarrollo", subtitle: "Estamos puliendo los algoritmos para darte los mejores insights.")
                .tabItem {
                    Label("Estadisticas", systemImage: "chart.bar")
                }
                .tag(1)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.modelContainer)
       
}
