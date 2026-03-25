//
//  ContentView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// La vista radice dell'applicazione che configura il sistema di navigazione per iOS 15.
///
/// Utilizza `NavigationView` e un `NavigationLink` programmabile per gestire il flusso
/// definito dall' `AppCoordinator`.
struct ContentView: View {
    /// L'oggetto che gestisce lo stato della navigazione e le dipendenze.
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationView {
            HomeView(viewModel: coordinator.makeHomeViewModel())
                .background(
                    // NavigationLink silente per la gestione programmatica della rotta.
                    // iOS 15 richiede questo approccio per separare la logica dalla View.
                    NavigationLink(
                        isActive: Binding(
                            get: { !coordinator.path.isEmpty },
                            set: { isNowActive in
                                // Se l'utente torna indietro (swipe o tasto back), svuotiamo il path.
                                if !isNowActive { coordinator.path = [] }
                            }
                        ),
                        destination: {
                            // Risolve la destinazione in base all'ultima rotta nel path.
                            if case let .detail(name) = coordinator.path.last {
                                DetailView(viewModel: coordinator.makeDetailViewModel(for: name))
                            } else {
                                EmptyView()
                            }
                        },
                        label: { EmptyView() }
                    )
                )
        }
        // Permette alle viste figlie di accedere al coordinator se necessario.
        .environmentObject(coordinator)
        // Forza lo stile a colonna singola (evita lo split view su iPad/iPhone Max in landscape).
        .navigationViewStyle(.stack)
    }
}

#Preview {
    ContentView()
}
