//
//  lazy.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
import SwiftUI
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}

