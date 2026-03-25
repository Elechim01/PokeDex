//
//  PokeDexApp.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI
/// Il punto di ingresso principale dell'applicazione PokeDex.
///
/// Configura l'ambiente iniziale e lancia la `ContentView` come radice della gerarchia delle viste.
@main
struct PokeDexApp: App {
    var body: some Scene {
        WindowGroup {
            // Avviamo l'app dalla ContentView, che gestirà il Coordinator.
            ContentView()
        }
    }
}
