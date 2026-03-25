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
    
    /// Inizializza il ViewModel con lo Use Case per i dati e il coordinatore per la navigazione.
    /// - Parameters:
    ///   - getPokemonListUseCase: Lo Use Case per il recupero dei dati.
    ///   - coordinator: Il coordinatore per gestire i flussi di navigazione.
    init(getPokemonListUseCase: GetPokemonListUseCase, coordinator: AppCoordinator) {
        self.getPokemonListUseCase = getPokemonListUseCase
        self.coordinator = coordinator
    }
    
    /// Restituisce la lista filtrata dei Pokemon in base al testo inserito nella barra di ricerca.
    ///
    /// Se `searchText` è vuoto, restituisce l'intera `pokemonList`. Il filtro non è case-sensitive.
    var filteredPokemon: [PokemonModel] {
        if searchText.isEmpty { return pokemonList }
        return pokemonList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    /// Carica asincronamente la prossima pagina di Pokemon.
    ///
    /// Incrementa automaticamente l'`currentOffset` in base al `limit` dopo ogni caricamento riuscito.
    /// Impedisce chiamate multiple simultanee tramite il controllo sulla proprietà `isLoading`.
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
    
    /// Naviga verso la schermata di dettaglio del Pokemon selezionato.
    /// - Parameter pokemon: Il modello del Pokemon da visualizzare nel dettaglio.
    func selectPokemon(_ pokemon: PokemonModel) {
        coordinator?.goToDetail(pokemonName: pokemon.name.lowercased())
    }
}
