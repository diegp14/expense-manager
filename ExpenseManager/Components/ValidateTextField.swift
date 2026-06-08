//
//  ValidateTextField.swift
//  ExpenseTracker
//
//  Created by Diego Guzman on 08/03/26.
//

import SwiftUI

struct ValidateTextField: View {
    let title: String
    @Binding var text: String
    let errorMessage: String?
    var isSecure: Bool = false
    var onEditingChanged: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if isSecure {
                SecureField(title, text: $text)
                    .textFieldStyle(.roundedBorder)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(errorMessage != nil ? Color.red : Color.clear, lineWidth: 1.5)
                    )
                    .onChange(of: text) { _, _ in onEditingChanged?() }
            } else {
                TextField(title, text: $text)
//                    .textFieldStyle(.roundedBorder)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(errorMessage != nil ? Color.red : Color.clear, lineWidth: 1.5)
                    )
                    .onChange(of: text) { _, _ in onEditingChanged?() }
            }
            
            if let error = errorMessage {
                Label(error, systemImage: "exclamationmark.circle.fill")
                    .font(.caption)
                    .foregroundColor(.red)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }
}

#Preview {
    @Previewable @State var text: String = ""
    ValidateTextField(title: "Nombre", text: $text, errorMessage: "Error" )
}
