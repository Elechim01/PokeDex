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
    
    // Stati per le sezioni collassabili (Must Have)
    @Published var isAbilitiesExpanded: Bool = false
    @Published var isMovesExpanded: Bool = false
    
    private let pokemonName: String
    private let getPokemonDetailUseCase: GetPokemonDetailUseCase
    
    init(pokemonName: String, getPokemonDetailUseCase: GetPokemonDetailUseCase) {
        self.pokemonName = pokemonName
        self.getPokemonDetailUseCase = getPokemonDetailUseCase
    }
    
    /// Carica i dettagli del Pokemon usando lo Use Case dedicato.
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
