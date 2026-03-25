//
//  AppCoordinator.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation
import Combine

/// Il Coordinator principale che gestisce il flusso di navigazione dell'app.
///
/// Responsabile della creazione dei ViewModel e della gestione dello stack di navigazione.
/// - Note: Utilizza `@Published` per aggiornare la UI quando cambia la rotta.
final class AppCoordinator: ObservableObject {
    @Published var path: [Route] = []
    
    /// Definisce le possibili destinazioni navigabili nell'app.
    enum Route: Hashable {
        case detail(pokemonName: String)
    }
    
    private let networkService: NetworkServiceProtocol
    private let repository: PokemonRepositoryProtocol
    
    /// Inizializza il Coordinator e configura le dipendenze principali.
    init() {
        // Inizializzazione delle dipendenze centralizzata
        self.networkService = NetworkService()
        self.repository = PokemonRepository(networkService: networkService)
    }
    
    /// Crea e configura il ViewModel per la schermata Home.
    /// - Returns: Un'istanza di `HomeViewModel` configurata con i necessari Use Case.
    func makeHomeViewModel() -> HomeViewModel {
        let useCase = GetPokemonListUseCase(repository: repository)
        return HomeViewModel(getPokemonListUseCase: useCase, coordinator: self)
    }
    
    /// Crea e configura il ViewModel per la schermata di dettaglio di un Pokemon.
    /// - Parameter name: Il nome del Pokemon da visualizzare.
    /// - Returns: Un'istanza di `DetailViewModel` pronta per l'uso.
    func makeDetailViewModel(for name: String) -> DetailViewModel {
        let useCase = GetPokemonDetailUseCase(repository: repository)
        return DetailViewModel(pokemonName: name, getPokemonDetailUseCase: useCase)
    }
    
    /// Aggiunge una nuova destinazione allo stack di navigazione per visualizzare il dettaglio.
    /// - Parameter pokemonName: Il nome del Pokemon verso cui navigare.
    func goToDetail(pokemonName: String) {
        path.append(.detail(pokemonName: pokemonName))
    }
}
