//
//  GetPokemonDetailUseCase.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Use Case per il recupero del dettaglio di un singolo Pokemon.
final class GetPokemonDetailUseCase {
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Esegue il recupero dei dettagli.
    /// - Parameter name: Il nome del pokemon.
    /// - Returns: Il modello di dettaglio per la UI.
    func execute(for name: String) async throws -> PokemonDetailModel {
        return try await repository.getPokemonDetail(for: name)
    }
}
