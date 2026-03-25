//
//  DetailViewModelTests.swift
//  PokeDexTests
//
//  Created by Michele Manniello on 25/03/26.
//

import XCTest
@testable import PokeDex

@MainActor
final class DetailViewModelTests: XCTestCase {
    var sut: DetailViewModel!
    var mockRepo: MockPokemonRepository!

    override func setUp() {
        super.setUp()
        mockRepo = MockPokemonRepository()
        sut = DetailViewModel(pokemonName: "bulbasaur", repository: mockRepo)
    }

    /// Verifica che al caricamento le sezioni siano collassate (Requisito Mandatory).
    func test_detail_sections_initial_state() async {
        // When
        await sut.loadDetail()
        
        // Then
        XCTAssertFalse(sut.isAbilitiesExpanded, "Le abilità devono essere chiuse inizialmente")
        XCTAssertFalse(sut.isMovesExpanded, "Le mosse devono essere chiuse inizialmente")
    }
}
