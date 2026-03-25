//
//  PokemonRowView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// Una riga della lista che mostra il nome e l'immagine del Pokemon.
struct PokemonRowView: View {
    let pokemon: PokemonModel
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: pokemon.imageUrl) { image in
                image.resizable()
                     .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text(pokemon.name)
                .font(.headline)
                .accessibilityIdentifier("pokemon_name_label")
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
