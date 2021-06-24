//
//  Location.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
struct Location: Decodable,Identifiable {
    let id: Int
    let name: String
    let region: String
    let generation: String
}

let SAMPLE_LOCATION = Location(id:1,name:"Canalave City",region: "sinnoh",generation: "generation-iv")
