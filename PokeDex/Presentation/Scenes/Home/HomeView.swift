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
            SearchBar()
            
            // Lista dei Pokemon filtrati
            ForEach(viewModel.filteredPokemon) { pokemon in
                Button {
                    viewModel.selectPokemon(pokemon)
                } label: {
                    PokemonRowView(pokemon: pokemon)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier("pokemonRow_\(pokemon.name.lowercased())")
                .onAppear {
                    // Logica di paginazione: carica quando appare l'ultimo elemento della lista totale
                    if pokemon == viewModel.pokemonList.last {
                        Task { await viewModel.loadPokemon() }
                    }
                }
            }
            
            // Spinner di caricamento per il feedback visivo della paginazione
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .navigationTitle("Pokedex")
        .task {
            // Caricamento iniziale all'apparizione della vista
            await viewModel.loadPokemon()
        }
    }
    
    /// Genera una barra di ricerca personalizzata con pulsante di cancellazione.
    /// - Returns: Una vista contenente un campo di testo e icone di sistema.
    @ViewBuilder
    func SearchBar() -> some View {
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
        .listRowInsets(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
        .listRowSeparator(.hidden) // Nasconde la linea della lista per la barra di ricerca
    }
}

#Preview {
    ContentView()
}
