//
//  PokemonDetailDTO.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Dettaglio completo del Pokemon ricevuto dal server tramite PokeAPI.
///
/// Questa struttura mappa l'oggetto JSON restituito dall'endpoint `/pokemon/{id_or_name}/`.
struct PokemonDetailDTO: Codable {
    /// L'identificativo univoco del Pokemon.
    let id: Int
    /// Il nome originale del Pokemon (solitamente in minuscolo).
    let name: String
    /// L'altezza del Pokemon espressa in decimetri.
    let height: Int
    /// Il peso del Pokemon espresso in ettogrammi.
    let weight: Int
    /// Contenitore per gli URL delle immagini (sprites).
    let sprites: SpritesDTO
    /// Elenco delle abilità possedute dal Pokemon.
    let abilities: [AbilitySlotDTO]
    /// Elenco delle mosse che il Pokemon può apprendere.
    let moves: [MoveSlotDTO]
    
    /// Contenitore per le risorse grafiche del Pokemon.
    struct SpritesDTO: Codable {
        /// URL dell'immagine frontale predefinita.
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
    
    /// Rappresenta uno slot nell'elenco delle abilità.
    struct AbilitySlotDTO: Codable {
        /// I dettagli dell'abilità specifica.
        let ability: NameDTO
    }
    
    /// Rappresenta uno slot nell'elenco delle mosse.
    struct MoveSlotDTO: Codable {
        /// I dettagli della mossa specifica.
        let move: NameDTO
    }
    
    /// Struttura generica per oggetti dell'API che contengono solo un nome.
    /// Utilizzata per mappare abilità, mosse e tipi.
    struct NameDTO: Codable {
        /// Il nome della risorsa (es. "overgrow", "tackle").
        let name: String
    }
}
