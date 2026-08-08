//
//  ContentView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI
import SwiftData
import LocalAuthentication

struct ContentView: View {
    
    @State private var selection = 0
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        if isUnlocked {
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
        } else {
            ZStack {
                background
                VStack {
                    Text("Mis Gastos")
                        .font(Font.largeTitle.bold())
                    Image(systemName: "creditcard.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.gray)
                    Button {
                        aunthenticate()
                    } label: {
                        HStack {
                            Text("Inicia sesión Face ID")
                            Image(systemName: "faceid")
                        }
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            

        }
    }
    private var background: some View {
        LinearGradient(
            colors: [.cyan, .cyan.opacity(0.15)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    func aunthenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthentication, error: &error) {
            let reason = "We need to unlock your data"
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                if success {
                    isUnlocked = true
                }else {
                    isUnlocked = false
                }
            }
        }else {
            // No biometrics
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.modelContainer)
       
}
