//
//  PokemonMapper.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Classe dedicata alla trasformazione dei dati grezzi (DTO) in entità di business (Domain Models).
///
/// Isola la logica di parsing e conversione delle unità di misura, mantenendo i modelli UI puliti.
final class PokemonMapper {
    
    /// Converte un oggetto di risposta della lista in un modello per la visualizzazione.
    /// - Parameter dto: L'entry grezza proveniente dall'API.
    /// - Returns: Un `PokemonModel` con ID estratto e URL immagine configurato.
    static func map(_ dto: PokemonEntryDTO) -> PokemonModel {
        // Estraiamo l'ID dall'URL (es: "https://pokeapi.co/api/v2/pokemon/1/")
        // split(separator: "/") crea un array di sottostringhe; l'ultimo elemento è l'ID.
        let components = dto.url.split(separator: "/")
        let idString = components.last ?? "0"
        let id = Int(idString) ?? 0
        
        // URL immagine ufficiale (High Res) tramite GitHub Assets
        let imageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
        
        return PokemonModel(
            id: id,
            name: dto.name.capitalized,
            imageUrl: imageUrl
        )
    }
    
    /// Converte il dettaglio completo ricevuto dall'API nel modello specifico per la UI.
    ///
    /// Applica le conversioni per altezza (decimetri -> metri) e peso (ettogrammi -> kg).
    /// - Parameter dto: Il DTO dettagliato del Pokemon.
    /// - Returns: Un `PokemonDetailModel` con dati formattati e pronti all'uso.
    static func mapDetail(_ dto: PokemonDetailDTO) -> PokemonDetailModel {
        return PokemonDetailModel(
            id: dto.id,
            name: dto.name.capitalized,
            imageUrl: URL(string: dto.sprites.frontDefault),
            height: Double(dto.height) / 10.0, // Conversione decimetri -> metri
            weight: Double(dto.weight) / 10.0, // Conversione ettogrammi -> kg
            abilities: dto.abilities.map { $0.ability.name.capitalized },
            moves: dto.moves.map { $0.move.name.capitalized }
        )
    }
}
