//
//  PokemonDetailModel.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

struct PokemonDetailModel {
    let id: Int
    let name: String
    let imageUrl: URL?
    let height: Double // In metri
    let weight: Double // In kg
    let abilities: [String]
    let moves: [String]
}
