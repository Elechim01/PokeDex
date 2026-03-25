//
//  PokemonList.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Risposta di primo livello per la lista paginata di PokeAPI.
struct PokemonListResponseDTO: Codable {
    /// Numero totale di Pokemon disponibili nell'API.
    let count: Int
    /// URL per recuperare la pagina successiva, se presente.
    let next: String?
    /// URL per recuperare la pagina precedente, se presente.
    let previous: String?
    /// Array di entry contenenti nome e URL del dettaglio.
    let results: [PokemonEntryDTO]
}


/// Rappresenta una singola voce nella risposta della lista dei Pokemon.
///
/// Ogni entry fornisce il nome del Pokemon e il link al suo dettaglio completo.
struct PokemonEntryDTO: Codable {
    /// Il nome identificativo del Pokemon (es. "bulbasaur").
    let name: String
    
    /// L'URL completo per recuperare i dettagli specifici di questo Pokemon.
    /// - Note: L'ID del Pokemon viene solitamente estratto dalla fine di questa stringa.
    let url: String
}
