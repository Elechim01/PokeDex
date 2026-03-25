//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation
import Combine

/// ViewModel per la gestione dei dettagli di un singolo Pokemon.
@MainActor
final class DetailViewModel: ObservableObject {
    @Published var pokemonDetail: PokemonDetailModel?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Stati per le sezioni collassabili (Requisito tecnico)
    @Published var isAbilitiesExpanded: Bool = false
    @Published var isMovesExpanded: Bool = false
    
    private let pokemonName: String
    private let getPokemonDetailUseCase: GetPokemonDetailUseCase
    
    /// Inizializza il ViewModel con il nome del Pokemon e lo Use Case per il recupero dei dettagli.
    /// - Parameters:
    ///   - pokemonName: Il nome del Pokemon da visualizzare.
    ///   - getPokemonDetailUseCase: Lo Use Case per la logica di business del dettaglio.
    init(pokemonName: String, getPokemonDetailUseCase: GetPokemonDetailUseCase) {
        self.pokemonName = pokemonName
        self.getPokemonDetailUseCase = getPokemonDetailUseCase
    }
    
    /// Carica i dettagli del Pokemon usando lo Use Case dedicato.
    ///
    /// Questa funzione gestisce lo stato di caricamento (`isLoading`) e
    /// cattura eventuali errori popolando `errorMessage`.
    ///
    /// - Note: Viene eseguita asincronamente tramite `async/await`.
    func loadDetail() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Chiamata tramite UseCase
            self.pokemonDetail = try await getPokemonDetailUseCase.execute(for: pokemonName)
        } catch {
            self.errorMessage = "Impossibile caricare i dettagli di \(pokemonName.capitalized)."
        }
        
        isLoading = false
    }
}
