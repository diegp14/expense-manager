//
//  BottonMessageTextFieldStyle.swift
//  ExpenseManager
//
//  Created by Diego Guzman on 24/05/26.
//

import Foundation
import SwiftUI

enum MessageType: CaseIterable {
    case info
    case error
    case warning
    case success
    
    var color: Color {
        switch self {
        case .info:
            return Color.blue
        case .error:
            return Color.red
        case .warning:
            return Color.yellow
        case .success:
            return Color.green
        }
    }
}

struct BottonMessageTextFieldStyle: TextFieldStyle {
    var messageType: MessageType
    var message: String?
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading) {
            configuration
                .foregroundColor(.primary)
            if let message = message {
                Divider()
                    .background(messageType.color, in: .buttonBorder)
                Text(message)
                    .foregroundColor(messageType.color)
            }
        }
    }
    
}

extension TextFieldStyle where Self == BottonMessageTextFieldStyle {
    static func bottonMessage(message: String? = nil, type: MessageType = .info) -> Self {
        return BottonMessageTextFieldStyle(messageType: type, message: message)
    }
}

struct BottonMessageModifier: ViewModifier {
    var message: String?
    var type: MessageType?
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading) {
            content
            if let type = type, let message = message, !message.isEmpty {
                Divider()
                    .background(type.color, in: .buttonBorder)
                Text(message)
                    .foregroundColor(type.color)
            }
        }
    }
}
