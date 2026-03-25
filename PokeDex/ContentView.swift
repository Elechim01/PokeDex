//
//  ContentView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationView {
            HomeView(viewModel: coordinator.makeHomeViewModel())
                .background(
                    // Gestione navigazione tramite rotte del coordinator
                    NavigationLink(
                        isActive: Binding(
                            get: { !coordinator.path.isEmpty },
                            set: { if !$0 { coordinator.path = [] } }
                        ),
                        destination: {
                            if case let .detail(name) = coordinator.path.last {
                                DetailView(viewModel: coordinator.makeDetailViewModel(for: name))
                            }
                        },
                        label: { EmptyView() }
                    )
                )
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}
