//
//  MockPokemonRepository.swift
//  PokeDexTests
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation
@testable import PokeDex

import Foundation

/// Mock del repository utilizzato esclusivamente per gli Unit Test.
///
/// Permette di simulare risposte di rete caricate da file locali (stub) o di forzare errori.
/// - Note: Marcato con `@MainActor` per garantire la thread-safety durante i test.
@MainActor
final class MockPokemonRepository: PokemonRepositoryProtocol {
    
    /// Flag per determinare se il mock deve simulare un fallimento di rete.
    var shouldReturnError = false

    /// Carica i dati dal file JSON locale `pokemon_list_stub.json` per simulare la risposta dell'API.
    /// - Returns: Un array di DTO estratti dal file di test.
    private func loadStubData() -> [PokemonEntryDTO] {
        // Cerchiamo il bundle del test attuale per trovare le risorse locali
        guard let url = Bundle(for: type(of: self)).url(forResource: "pokemon_list_stub", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(PokemonListResponseDTO.self, from: data) else {
            return []
        }
        return response.results
    }

    /// Implementazione del protocollo che ritorna i dati dello stub o lancia un errore.
    func getPokemonList(offset: Int, limit: Int) async throws -> [PokemonModel] {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        // Riutilizziamo il mapper di produzione per garantire che la logica di conversione sia testata
        return loadStubData().map { PokemonMapper.map($0) }
    }

    /// Ritorna un modello di dettaglio fisso per scopi di test.
    func getPokemonDetail(for name: String) async throws -> PokemonDetailModel {
        if shouldReturnError { throw NetworkError.invalidResponse }
        
        // Mock di un Pokemon generico per validare la UI del dettaglio
        return PokemonDetailModel(
            id: 1,
            name: name.capitalized,
            imageUrl: nil,
            height: 0.7,
            weight: 6.9,
            abilities: ["Overgrow"],
            moves: ["Tackle"]
        )
    }
}
