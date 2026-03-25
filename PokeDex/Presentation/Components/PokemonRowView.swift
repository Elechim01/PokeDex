//
//  PokemonRowView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// Una riga della lista che mostra il nome e l'immagine del Pokemon.
/// - Parameter pokemon: Il modello contenente i dati del Pokemon da visualizzare.
struct PokemonRowView: View {
    let pokemon: PokemonModel
    
    var body: some View {
        HStack(spacing: 16) {
            // Immagine del Pokemon caricata asincronamente
            AsyncImage(url: pokemon.imageUrl) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .background(Color(.systemGray6)) // Aggiunge un fondo neutro se l'immagine è trasparente
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            // Nome del Pokemon con formattazione
            Text(pokemon.name.capitalized) // Usiamo capitalized per un look più pulito
                .font(.headline)
                .accessibilityIdentifier("pokemon_name_\(pokemon.name.lowercased())")
            
            Spacer()
            
            // Un piccolo indicatore di navigazione opzionale
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
