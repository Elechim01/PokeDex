//
//  PokemonMapper.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Classe dedicata alla trasformazione dei dati grezzi in entità di business.
final class PokemonMapper {
    
    /// Converte la risposta della lista in un array di modelli Domain.
    static func map(_ dto: PokemonEntryDTO) -> PokemonModel {
        // Estraiamo l'ID dall'URL (es: "https://pokeapi.co/api/v2/pokemon/1/")
        let idString = dto.url.split(separator: "/").last ?? "0"
        let id = Int(idString) ?? 0
        
        // URL immagine ufficiale (High Res)
        let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
        
        return PokemonModel(
            id: id,
            name: dto.name.capitalized,
            imageUrl: imageUrl
        )
    }
    
    /// Converte il dettaglio API nel modello per la UI.
    static func mapDetail(_ dto: PokemonDetailDTO) -> PokemonDetailModel {
        return PokemonDetailModel(
            id: dto.id,
            name: dto.name.capitalized,
            imageUrl: URL(string: dto.sprites.frontDefault),
            height: Double(dto.height) / 10.0, // Conversione in metri
            weight: Double(dto.weight) / 10.0, // Conversione in kg
            abilities: dto.abilities.map { $0.ability.name.capitalized },
            moves: dto.moves.map { $0.move.name.capitalized }
        )
    }
}
