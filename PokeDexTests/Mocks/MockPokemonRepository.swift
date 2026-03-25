//
//  MockPokemonRepository.swift
//  PokeDexTests
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation
@testable import PokeDex

final class MockPokemonRepository: PokemonRepositoryProtocol {
    var shouldReturnError = false

    /// Carica i dati dal file JSON locale per simulare l'API.
    private func loadStubData() -> [PokemonEntryDTO] {
        guard let url = Bundle(for: type(of: self)).url(forResource: "pokemon_list_stub", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(PokemonListResponseDTO.self, from: data) else {
            return []
        }
        return response.results
    }

    func getPokemonList(offset: Int, limit: Int) async throws -> [PokemonModel] {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        // Usiamo il mapper che abbiamo scritto prima per convertire i DTO in modelli Domain
        return loadStubData().map { PokemonMapper.map($0) }
    }

    func getPokemonDetail(for name: String) async throws -> PokemonDetailModel {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        // Ritorno un dato fisso per il dettaglio (puoi creare uno stub anche per questo volendo)
        return PokemonDetailModel(
            id: 1, name: name.capitalized, imageUrl: nil,
            height: 0.7, weight: 6.9,
            abilities: ["Overgrow"], moves: ["Tackle"]
        )
    }
}
