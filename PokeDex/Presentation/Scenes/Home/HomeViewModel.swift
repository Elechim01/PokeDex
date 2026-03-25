//
//  HomeViewModel.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation
import Combine

/// ViewModel per la gestione della lista Pokemon, ricerca e paginazione.
@MainActor
final class HomeViewModel: ObservableObject {
    @Published var pokemonList: [PokemonModel] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private let getPokemonListUseCase: GetPokemonListUseCase
    private weak var coordinator: AppCoordinator?
    private var currentOffset = 0
    private let limit = 20
    
    init(getPokemonListUseCase: GetPokemonListUseCase, coordinator: AppCoordinator) {
        self.getPokemonListUseCase = getPokemonListUseCase
        self.coordinator = coordinator
    }
    
    /// Filtra la lista in base al testo inserito nella barra di ricerca.
    var filteredPokemon: [PokemonModel] {
        if searchText.isEmpty { return pokemonList }
        return pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    /// Carica la prossima pagina di Pokemon.
    func loadPokemon() async {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let newPokemon = try await getPokemonListUseCase.execute(offset: currentOffset, limit: limit)
            self.pokemonList.append(contentsOf: newPokemon)
            self.currentOffset += limit
        } catch {
            print("Errore caricamento: \(error)")
        }
        isLoading = false
    }
    
    func selectPokemon(_ pokemon: PokemonModel) {
        coordinator?.goToDetail(pokemonName: pokemon.name.lowercased())
    }
}
