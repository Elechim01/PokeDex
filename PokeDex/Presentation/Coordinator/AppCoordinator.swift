//
//  AppCoordinator.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation
import Combine

/// Il Coordinator principale che gestisce il flusso di navigazione dell'app.
/// - Note: Utilizza @Published per aggiornare la UI quando cambia la rotta.
class AppCoordinator: ObservableObject {
    @Published var path: [Route] = []
    
    /// Definisce le possibili destinazioni nell'app.
    enum Route: Hashable {
        case detail(pokemonName: String)
    }
    
    private let networkService: NetworkServiceProtocol
    private let repository: PokemonRepositoryProtocol
    
    init() {
        // Inizializzazione delle dipendenze centralizzata
        self.networkService = NetworkService()
        self.repository = PokemonRepository(networkService: networkService)
    }
    
    /// Crea il ViewModel per la Home caricando le dipendenze necessarie.
    func makeHomeViewModel() -> HomeViewModel {
        let useCase = GetPokemonListUseCase(repository: repository)
        return HomeViewModel(getPokemonListUseCase: useCase, coordinator: self)
    }
    
    /// Crea il ViewModel per il dettaglio di un Pokemon.
    func makeDetailViewModel(for name: String) -> DetailViewModel {
        let useCase = GetPokemonDetailUseCase(repository: repository)
        return DetailViewModel(pokemonName: name, getPokemonDetailUseCase: useCase)
    }
    
    /// Naviga verso il dettaglio di un Pokemon.
    func goToDetail(pokemonName: String) {
        path.append(.detail(pokemonName: pokemonName))
    }
}
