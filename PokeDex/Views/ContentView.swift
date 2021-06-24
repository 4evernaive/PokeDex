//
//  ContentView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                PokemonView()
                    .tabItem {
                        Label("Pokémon", systemImage: "circle")
                    }
                ItemView()
                    .tabItem {
                        Label("Item", systemImage: "pills")
                    }
                LocationView()
                    .tabItem {
                        Label("Location", systemImage: "mappin.and.ellipse")
                    }
                CoreMLView()
                    .tabItem {
                        Label("CoreML", systemImage: "tortoise")
                    }
            }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
