//
//  PokemonDetailDTO.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

struct PokemonDetailDTO: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: SpritesDTO
    let abilities: [AbilitySlotDTO]
    let moves: [MoveSlotDTO]
    
    struct SpritesDTO: Codable {
        let frontDefault: String
        enum CodingKeys: String, CodingKey { case frontDefault = "front_default" }
    }
    
    struct AbilitySlotDTO: Codable {
        let ability: NameDTO
    }
    
    struct MoveSlotDTO: Codable {
        let move: NameDTO
    }
    
    struct NameDTO: Codable {
        let name: String
    }
}
