//
//  DetailView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// Vista di dettaglio che mostra info, abilità e mosse di un Pokemon.
struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 50)
                } else if let pokemon = viewModel.pokemonDetail {
                    // Intestazione con Immagine e Nome
                    AsyncImage(url: pokemon.imageUrl) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    
                    Text(pokemon.name)
                        .font(.largeTitle)
                        .bold()
                    
                    // Altezza e Peso (Must Have 3)
                    HStack(spacing: 40) {
                        VStack {
                            Text("\(String(format: "%.1f", pokemon.height)) m")
                                .font(.title2).bold()
                            Text("Altezza").font(.caption).foregroundColor(.gray)
                        }
                        VStack {
                            Text("\(String(format: "%.1f", pokemon.weight)) kg")
                                .font(.title2).bold()
                            Text("Peso").font(.caption).foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    // Sezione Abilità Collassabile (Must Have 1)
                    CollapsibleSection(
                        title: "Abilità",
                        isExpanded: $viewModel.isAbilitiesExpanded,
                        items: pokemon.abilities
                    )
                    
                    // Sezione Mosse Collassabile (Must Have 2)
                    CollapsibleSection(
                        title: "Mosse",
                        isExpanded: $viewModel.isMovesExpanded,
                        items: pokemon.moves
                    )
                    
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        // Carica i dati all'apparizione della vista
        .task {
            await viewModel.loadDetail()
        }
    }
}

/// Componente riutilizzabile per creare sezioni collassabili.
struct CollapsibleSection: View {
    let title: String
    @Binding var isExpanded: Bool
    let items: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray5))
            }
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(items, id: \.self) { item in
                        Text("• \(item)")
                            .padding(.leading)
                    }
                }
                .padding(.vertical)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
