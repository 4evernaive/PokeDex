//
//  ItemView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI
import Kingfisher

struct ItemView: View {
    @State private var searchText :String = ""
    private let gridItems = [GridItem(.flexible())]
    @ObservedObject var viewModel = ItemViewModel()
    var body: some View {
        NavigationView {
           
            ScrollView {
                Spacer()
                Spacer()
                SearchBar(text: $searchText)
                Spacer()
                Spacer()
                LazyVGrid(columns: gridItems, spacing: 16) {
                   
                    let dataSource = viewModel.item
                   
                    ForEach(dataSource.filter({ searchText.isEmpty ? true : $0.name.capitalized.contains(searchText.capitalized) }))  { item in
            
                                ItemCell(item: item)
                                   
                                    .padding(.horizontal)
       
                    }
                }
            }
            .onAppear {
                viewModel.fetchItem()
            }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Pokédex")
        }
    }
   
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView().preferredColorScheme(.dark)
    }
}
