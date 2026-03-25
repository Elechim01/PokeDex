//
//  PokemonModel.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Rappresenta un Pokemon sintetico per la visualizzazione nella lista principale.
/// - Note: Conforme a `Identifiable` per l'uso diretto nelle `List` di SwiftUI.
struct PokemonModel: Identifiable, Equatable, Hashable, Sendable {
    let id: Int
    let name: String
    let imageUrl: URL?
}
