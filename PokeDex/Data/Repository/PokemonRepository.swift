//
//  PokemonRepository.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Implementazione concreta del repository che gestisce il recupero dei dati da PokeAPI.
///
/// Questa classe funge da ponte tra il servizio di rete e gli Use Case, trasformando i DTO in modelli di dominio.
final class PokemonRepository: PokemonRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    /// Inizializza il repository con un servizio di rete.
    /// - Parameter networkService: Il protocollo per effettuare chiamate HTTP.
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    /// Recupera una lista paginata di Pokemon.
    /// - Parameters:
    ///   - offset: Punto di partenza della lista.
    ///   - limit: Numero di elementi da scaricare.
    /// - Returns: Un array di `PokemonModel` pronti per la visualizzazione.
    /// - Throws: `URLError` se l'URL è invalido o errori di rete durante il fetch.
    func getPokemonList(offset: Int, limit: Int) async throws -> [PokemonModel] {
        guard let url = URL(string: "\(baseURL)?offset=\(offset)&limit=\(limit)") else {
            throw URLError(.badURL)
        }
        
        // Recupero dei dati grezzi (DTO) tramite il servizio di rete
        let response: PokemonListResponseDTO = try await networkService.fetchData(from: url)
        
        // Trasformazione (Mapping) verso i modelli della UI
        return response.results.map { PokemonMapper.map($0) }
    }
    
    /// Recupera i dettagli completi di un singolo Pokemon tramite il suo nome.
    /// - Parameter name: Il nome del Pokemon da cercare (verrà automaticamente convertito in minuscolo).
    /// - Returns: Un oggetto `PokemonDetailModel` con abilità, mosse e dati fisici.
    /// - Throws: Errori di rete o di decoding.
    func getPokemonDetail(for name: String) async throws -> PokemonDetailModel {
        guard let url = URL(string: "\(baseURL)/\(name.lowercased().trimmingCharacters(in: .whitespaces))") else {
            throw URLError(.badURL)
        }
        
        let dto: PokemonDetailDTO = try await networkService.fetchData(from: url)
        return PokemonMapper.mapDetail(dto)
    }
}
