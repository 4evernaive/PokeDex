//
//  PokemonViewModel.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
let DATA_URL = "https://raw.githubusercontent.com/4evernaive/vis2021s/master/saa.json"
class PokemonViewModel: ObservableObject {
    @Published var pokemon = [Pokemon]()
    
    func fetchPM() {
        guard let url = URL(string: DATA_URL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                     do {
                         let pokemon = try JSONDecoder().decode([Pokemon].self, from: data)
                        DispatchQueue.main.async {
                            self.pokemon = pokemon
                        }
                     } catch  {
                         print(error)
                     }
                 }
          
        }.resume()
    }
}
