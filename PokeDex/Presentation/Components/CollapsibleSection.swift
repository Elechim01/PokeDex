//
//  CollapsibleSection.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// Un componente riutilizzabile che permette di mostrare o nascondere un contenuto al tap su un titolo.
///
/// Viene utilizzato principalmente per le sezioni "Abilità" e "Mosse" nel dettaglio del Pokemon.
struct CollapsibleSection<Content: View>: View {
    let title: String
    @Binding var isExpanded: Bool
    let content: Content

    /// Inizializzatore esplicito per supportare la sintassi @ViewBuilder.
    /// - Parameters:
    ///   - title: Il testo da mostrare nel pulsante della sezione.
    ///   - isExpanded: Binding allo stato booleano che controlla l'espansione.
    ///   - content: La vista (o gruppo di viste) da mostrare quando la sezione è espansa.
    init(title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.title = title
        self._isExpanded = isExpanded
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .rotationEffect(.degrees(isExpanded ? 90 : 0))
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("collapsible_button_\(title)")

            if isExpanded {
                VStack(alignment: .leading, spacing: 5) {
                    content
                }
                .padding(.vertical)
            }
        }
    }
}
