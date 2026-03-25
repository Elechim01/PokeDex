//
//  PokemonRepository.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Implementazione concreta del repository che utilizza PokeAPI via rete.
final class PokemonRepository: PokemonRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://pokeapi.co/api/v2/pokemon"
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getPokemonList(offset: Int, limit: Int) async throws -> [PokemonModel] {
        guard let url = URL(string: "\(baseURL)?offset=\(offset)&limit=\(limit)") else {
            throw URLError(.badURL)
        }
        
        // Chiamata DTO
        let response: PokemonListResponseDTO = try await networkService.fetchData(from: url)
        
        // Mappatura verso Domain Entity
        return response.results.map { PokemonMapper.map($0) }
    }
    
    func getPokemonDetail(for name: String) async throws -> PokemonDetailModel {
        guard let url = URL(string: "\(baseURL)/\(name.lowercased())") else {
            throw URLError(.badURL)
        }
        
        let dto: PokemonDetailDTO = try await networkService.fetchData(from: url)
        return PokemonMapper.mapDetail(dto)
    }
}
