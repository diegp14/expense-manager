//
//  ComingSoonView.swift
//  Manager Expense
//
//  Created by Diego Guzman on 14/03/26.
//

import SwiftUI

struct ComingSoonView: View {
    let icon: String
    let title: String
    let subtitle: String
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundStyle(.secondary)
            Text(title)
                .font(.title2)
                .bold()
            Text(subtitle)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

#Preview {
    let icon = "chart.pie.fill"
    let title = "Estadisticas proximamentes"
    let subtitle = "Estamos puliendo los algoritmos para darte los mejores insights."
    ComingSoonView(
        icon: icon, title: title, subtitle: subtitle
    )
}
