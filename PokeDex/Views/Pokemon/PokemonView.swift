//
//  PokemonView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI
import Kingfisher


struct PokemonView: View {
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()),GridItem(.flexible())]
    @ObservedObject var viewModel = PokemonViewModel()
    @State private var searchText :String = ""
    var body: some View {
        NavigationView {
           
            ScrollView {
                Spacer()
                Spacer()
                SearchBar(text: $searchText)
                Spacer()
                Spacer()
                Spacer()
                LazyVGrid(columns: gridItems, spacing: 20) {
                   
                    let dataSource = viewModel.pokemon
                   
                    ForEach(dataSource.filter({ searchText.isEmpty ? true : $0.name.capitalized.contains(searchText.capitalized) })) { pokemon in
                        NavigationLink(
                            destination: NavigationLazyView(PokemonDetailView(pokemon: pokemon)),
                            label: {
                                PokemonCell(pokemon: pokemon)
                                    .frame(width: 220, height: 108)
                                    .padding(.horizontal)
                            })
                        
                    }
                }
            }
            .onAppear {
                viewModel.fetchPM()
            }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Pokédex")
        }
    }
    
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView().preferredColorScheme(.dark)
    }
}
