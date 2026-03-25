//
//  NetworkService.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import Foundation

import Foundation

/// Errori personalizzati per gestire i fallimenti di rete in modo chiaro.
enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case serverError(Int)
}

protocol NetworkServiceProtocol {
    /// Esegue una richiesta di rete asincrona e decodifica il risultato.
    /// - Parameter url: L'URL della risorsa da scaricare.
    /// - Returns: Un oggetto di tipo `T` decodificato dal JSON.
    func fetchData<T: Decodable>(from url: URL) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    /// Utilizziamo una sessione configurata o quella standard.
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        // 1. Chiamata asincrona
        let (data, response) = try await session.data(from: url)
        
        // 2. Controllo della risposta HTTP
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        // 3. Decodifica
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
