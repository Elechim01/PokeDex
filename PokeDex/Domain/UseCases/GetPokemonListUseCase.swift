//
//  GetPokemonListUseCase.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Use Case per il recupero della lista dei Pokemon.
/// Contiene la logica di business specifica per la visualizzazione in Home.
final class GetPokemonListUseCase {
    private let repository: PokemonRepositoryProtocol
    
    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    /// Esegue il recupero della lista.
    /// - Parameters:
    ///   - offset: Punto di inizio.
    ///   - limit: Quanti elementi scaricare.
    /// - Returns: Lista di Pokemon pronti per la UI.
    /// - Throws: Un errore se la chiamata al repository fallisce.
    func execute(offset: Int, limit: Int) async throws -> [PokemonModel] {
        return try await repository.getPokemonList(offset: offset, limit: limit)
    }
}
