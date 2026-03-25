//
//  PokemonList.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

struct PokemonListResponseDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntryDTO]
}

struct PokemonEntryDTO: Codable {
    let name: String
    let url: String
}
