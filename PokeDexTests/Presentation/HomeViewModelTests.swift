//
//  HomeViewModelTests.swift
//  PokeDexTests
//
//  Created by Michele Manniello on 25/03/26.
//

import XCTest
@testable import PokeDex

@MainActor
final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var mockRepo: MockPokemonRepository!

    override func setUp() {
        super.setUp()
        mockRepo = MockPokemonRepository()
        let useCase = GetPokemonListUseCase(repository: mockRepo)
        let coordinator = AppCoordinator() // Mock o reale va bene qui
        sut = HomeViewModel(getPokemonListUseCase: useCase, coordinator: coordinator)
    }

    /// Testa che la lista venga popolata leggendo dallo stub JSON.
    func test_loadPokemon_from_stub_success() async {
        // When
        await sut.loadPokemon()
        print(sut.pokemonList.count)
        // Then
        XCTAssertEqual(sut.pokemonList.count, 2, "Dovrebbe caricare i 2 pokemon definiti nel file JSON")
        XCTAssertEqual(sut.pokemonList.first?.name, "Bulbasaur")
    }

    /// Testa che la ricerca filtri correttamente i dati caricati.
    func test_search_filtering() async {
        // Given
        await sut.loadPokemon()
        
        // When
        sut.searchText = "ivy"
        
        // Then
        XCTAssertEqual(sut.filteredPokemon.count, 1)
        XCTAssertEqual(sut.filteredPokemon.first?.name, "Ivysaur")
    }
}
