//
//  ItemCellViewModel.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
import SwiftUI

struct ItemCellViewModel {
    let item: Item

    var backgroundColor: UIColor {
        switch item.categories {
        case "standard-balls": return .systemIndigo
        case "vitamins": return .systemGreen
        case "stat-boosts": return .systemTeal
        case "special-balls": return .systemGray4
        case "status-cures": return .systemPurple
        case "healing": return .systemOrange
        case "revival": return .systemGray
        case "flying": return .systemBlue
        case "pp-recovery": return .systemPink
        default: return .systemRed
        }
    }

    init(item: Item) {
        self.item = item
    }
}
