//
//  HomeView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// La vista principale che mostra la lista dei Pokemon con ricerca e paginazione.
struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        List {
            // Barra di ricerca integrata nella lista
            Section {
               SearchBar()
            }
            
            // Lista dei Pokemon filtrati
            ForEach(viewModel.filteredPokemon) { pokemon in
                Button {
                    viewModel.selectPokemon(pokemon)
                } label: {
                    PokemonRowView(pokemon: pokemon)
                }
                .buttonStyle(.plain) // Rimuove il colore blu del bottone standard
                .accessibilityIdentifier("pokemonRow_\(pokemon.name.lowercased())")
                .onAppear {
                    if pokemon == viewModel.pokemonList.last {
                        Task { await viewModel.loadPokemon() }
                    }
                }
            }
            
            // Spinner di caricamento in fondo per la paginazione
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth:  .infinity)
                    .padding()
            }
        }
        .navigationTitle("Pokedex")
        // Caricamento iniziale
        .task {
            await viewModel.loadPokemon()
        }
    }
    
    @ViewBuilder
    func SearchBar() -> some View {
        Section {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField("Cerca Pokémon", text: $viewModel.searchText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                if !viewModel.searchText.isEmpty {
                    Button {
                        viewModel.searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
            )
        }
    }
    
}
