//
//  PokemonModel.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

struct PokemonModel: Identifiable,Equatable {
    let id: Int
    let name: String
    let imageUrl: URL?
}

