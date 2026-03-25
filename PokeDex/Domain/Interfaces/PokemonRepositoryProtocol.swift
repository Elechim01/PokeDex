//
//  PokemonRepositoryProtocol.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//
import Foundation

/// Protocollo che definisce le operazioni sui dati dei Pokemon.
/// Astrae l'origine dei dati (API o Mock) dal resto dell'applicazione.
protocol PokemonRepositoryProtocol {
    /// Recupera una lista paginata di Pokemon.
    /// - Parameters:
    ///   - offset: L'indice di partenza per la paginazione.
    ///   - limit: Il numero massimo di Pokemon da recuperare.
    /// - Returns: Un array di `PokemonModel`.
    func getPokemonList(offset: Int, limit: Int) async throws -> [PokemonModel]
    
    /// Recupera i dettagli completi di un singolo Pokemon.
    /// - Parameter name: Il nome del pokemon da cercare.
    /// - Returns: Un oggetto `PokemonDetailModel`.
    func getPokemonDetail(for name: String) async throws -> PokemonDetailModel
}
