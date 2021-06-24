//
//  Pokemon.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let front_imageUrl: String
    let back_imageUrl: String
    let description: String
    let height: Int
    let weight: Int
    let hp: Int
    let attack: Int
    let defense: Int
    let special_attack: Int
    let special_defense: Int
    let speed: Int
    let type: String
}

let SAMPLE_POKEMONB = Pokemon(id: 1,
                             name: "Bulbasaur",
                             front_imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                             back_imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
                             description: "Bulbasaur can be seen napping in bright sunlight. There is a seed on its back. By soaking up the sun’s rays, the seed grows progressively larger.",
                             height: 7,
                                     weight: 69,
                                     hp: 45,
                                     attack: 49,
                                     defense: 49,
                                     special_attack: 65,
                                     special_defense: 65,
                                     speed: 45,
                             type: "Poison")
