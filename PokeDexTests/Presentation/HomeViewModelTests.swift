//
//  HomeViewModelTests.swift
//  PokeDexTests
//
//  Created by Michele Manniello on 25/03/26.
//

import XCTest
@testable import PokeDex

import XCTest
@testable import PokeDex

/// Test di unità per il `HomeViewModel`.
/// Focus sul caricamento dei dati tramite stub e sulla logica di filtraggio della ricerca.
@MainActor
final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var mockRepo: MockPokemonRepository!

    /// Configura l'ambiente di test prima di ogni esecuzione.
    override func setUp() {
        super.setUp()
        mockRepo = MockPokemonRepository()
        let useCase = GetPokemonListUseCase(repository: mockRepo)
        let coordinator = AppCoordinator()
        
        // Inizializzazione del System Under Test (SUT)
        sut = HomeViewModel(getPokemonListUseCase: useCase, coordinator: coordinator)
    }

    /// Verifica che la lista dei Pokemon venga popolata correttamente leggendo dal file JSON locale (stub).
    /// - Note: Questo test valida indirettamente anche il `PokemonMapper` e il `MockPokemonRepository`.
    func test_loadPokemon_from_stub_success() async {
        // When
        await sut.loadPokemon()
        
        // Then
        // Nota: Assicurati che lo stub 'pokemon_list_stub.json' contenga esattamente 2 entry.
        XCTAssertEqual(sut.pokemonList.count, 2, "Dovrebbe caricare i 2 pokemon definiti nel file JSON di test")
        XCTAssertEqual(sut.pokemonList.first?.name, "Bulbasaur", "Il primo Pokemon caricato dovrebbe essere Bulbasaur")
    }

    /// Verifica che la logica di ricerca filtri correttamente i dati caricati in base al testo inserito.
    func test_search_filtering() async {
        // Given: Carichiamo i dati iniziali dallo stub
        await sut.loadPokemon()
        
        // When: L'utente inserisce una stringa di ricerca
        sut.searchText = "ivy"
        
        // Then: Verifichiamo che la lista filtrata contenga solo i risultati pertinenti
        XCTAssertEqual(sut.filteredPokemon.count, 1, "La ricerca dovrebbe restituire esattamente un risultato per 'ivy'")
        XCTAssertEqual(sut.filteredPokemon.first?.name, "Ivysaur", "Il risultato della ricerca dovrebbe essere Ivysaur")
    }
}
