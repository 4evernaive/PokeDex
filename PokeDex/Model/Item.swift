//
//  Item.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
struct Item: Decodable,Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let description: String
    let categories: String
}

let SAMPLE_ITEM = Item(id:1,name:"Master Ball",imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/master-ball.png",description: "The best Poké Ball with the ultimate level of\nperformance. With it, you will catch any wild\nPokémon without fail.",categories: "standard-balls")
