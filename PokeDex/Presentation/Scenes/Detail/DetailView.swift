//
//  DetailView.swift
//  PokeDex
//
//  Created by Michele Manniello on 25/03/26.
//

import SwiftUI

/// Vista di dettaglio che mostra info, abilità e mosse di un Pokemon.
struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 50)
                } else if let pokemon = viewModel.pokemonDetail {
                    AsyncImage(url: pokemon.imageUrl) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    
                    Text(pokemon.name)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack(spacing: 40) {
                        VStack {
                            Text("\(String(format: "%.1f", pokemon.height)) m")
                                .font(.title2).bold()
                            Text("Altezza").font(.caption).foregroundColor(.gray)
                        }
                        VStack {
                            Text("\(String(format: "%.1f", pokemon.weight)) kg")
                                .font(.title2).bold()
                            Text("Peso").font(.caption).foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    CollapsibleSection(title: "Abilità", isExpanded: $viewModel.isAbilitiesExpanded) {
                        ForEach(pokemon.abilities,id:\.self) { ability in
                            Text("• \(ability.capitalized)")
                        }
                    }

                    CollapsibleSection(title: "Mosse", isExpanded: $viewModel.isMovesExpanded) {
                        ForEach(pokemon.moves, id: \.self) { move in
                            Text("• \(move.capitalized)")
                        }
                    }
                    
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadDetail()
        }
    }
}

#Preview {
    ContentView()
}
