//
//  LocationCellViewModel.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
import SwiftUI

struct LocationCellViewModel {
    let location: Location
    
    var backgroundColor: UIColor {
        switch location.region {
        case "kanto": return .systemRed
        case "hoenn": return .systemGreen
        case "sinnoh": return .systemYellow
        case "unova": return .systemPurple
        case "johto": return .systemOrange
        case "kalos": return .systemGray
        case "alola": return .systemBlue
        case "galar": return .systemPink
        default: return .systemIndigo
        }
    }
    init(location: Location) {
        self.location = location
    }
}
