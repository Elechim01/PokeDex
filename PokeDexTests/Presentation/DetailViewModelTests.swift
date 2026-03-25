//
//  DetailViewModelTests.swift
//  PokeDexTests
//
//  Created by Michele Manniello on 25/03/26.
//

import XCTest
@testable import PokeDex

/// Test di unità per il `DetailViewModel`.
/// Focus sulla logica di caricamento e sullo stato iniziale della UI.
@MainActor
final class DetailViewModelTests: XCTestCase {
    var sut: DetailViewModel!
    var mockRepo: MockPokemonRepository!

    override func setUp() {
        super.setUp()
        mockRepo = MockPokemonRepository()
        let useCase = GetPokemonDetailUseCase(repository: mockRepo)
        // Inizializziamo il System Under Test (SUT)
        sut = DetailViewModel(pokemonName: "bulbasaur", getPokemonDetailUseCase: useCase)
    }

    /// Verifica che al caricamento le sezioni "Abilità" e "Mosse" siano collassate.
    /// - Note: Questo risponde al requisito funzionale obbligatorio della prova tecnica.
    func test_detail_sections_initial_state() async {
        // Given (setup già in setUp)
        
        // When
        await sut.loadDetail()
        
        // Then
        XCTAssertFalse(sut.isAbilitiesExpanded, "Le abilità devono essere chiuse per default")
        XCTAssertFalse(sut.isMovesExpanded, "Le mosse devono essere chiuse per default")
    }

    /// Verifica che i dettagli del Pokemon vengano caricati correttamente nel ViewModel.
    func test_loadDetail_success_populates_data() async {
        // When
        await sut.loadDetail()
        
        // Then
        XCTAssertNotNil(sut.pokemonDetail, "Il dettaglio del Pokemon non dovrebbe essere nil dopo il caricamento")
        XCTAssertEqual(sut.pokemonDetail?.name, "Bulbasaur", "Il nome del Pokemon dovrebbe essere formattato correttamente")
        XCTAssertNil(sut.errorMessage, "Non dovrebbe esserci alcun messaggio di errore in caso di successo")
    }
}
