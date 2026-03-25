//
//  NetworkService.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

/// Errori personalizzati per gestire i fallimenti di rete in modo chiaro e tipizzato.
enum NetworkError: Error {
    /// La risposta dal server non è un HTTPURLResponse valido.
    case invalidResponse
    /// Il JSON ricevuto non corrisponde al modello atteso (T.self).
    case decodingError
    /// Errore lato server con relativo codice HTTP (es. 404, 500).
    case serverError(Int)
}

/// Protocollo per il servizio di rete, facilita l'uso di Mock negli Unit Test.
protocol NetworkServiceProtocol {
    /// Esegue una richiesta di rete asincrona e decodifica il risultato.
    /// - Parameter url: L'URL della risorsa da scaricare.
    /// - Returns: Un oggetto di tipo `T` decodificato dal JSON.
    /// - Throws: `NetworkError` in caso di fallimento o errori di sistema URLSession.
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

/// Implementazione concreta del servizio di rete basata su URLSession.
final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession

    /// Inizializza il servizio con una sessione specifica.
    /// - Parameter session: La sessione da utilizzare (default: `.shared`).
    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Scarica i dati e tenta la decodifica in un tipo generico.
    /// - Note: Gestisce automaticamente il controllo degli status code HTTP (200-299).
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        // 1. Chiamata asincrona tramite async/await
        let (data, response) = try await session.data(from: url)
        
        // 2. Controllo della risposta HTTP
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        // 3. Decodifica dei dati
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Errore decoding per \(T.self): \(error)") // Utile in fase di debug
            throw NetworkError.decodingError
        }
    }
}
