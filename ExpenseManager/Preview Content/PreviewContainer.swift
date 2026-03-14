//
//  PreviewContainer.swift
//  Manager Expense
//
//  Created by Diego Guzman on 19/10/25.
//

import Foundation
import SwiftData

@MainActor
final class PreviewContainer {
    static let shared = PreviewContainer()
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init() {
        let schema = Schema([Expense.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
            try context.save()
        } catch {
            fatalError("\(error)")
        }
    }
    
    private func insertSampleData() {
        for expanse in Expense.sampleData {
            context.insert(expanse)
        }
    }
    
}
