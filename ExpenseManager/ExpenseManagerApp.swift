//
//  Manager_ExpenseApp.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import SwiftUI
import SwiftData

@main
struct ExpenseManagerApp: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    init () {
        let schema = Schema([Expense.self])
        let config = ModelConfiguration(schema: schema)
        do {
             container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("No se pudo cargar el modelo")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
