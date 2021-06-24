//
//  LocationView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var viewModel = LocationViewModel()
    @State var gg_flag :String=""
    var regions = ["kanto", "johto", "hoenn", "sinnoh","unova","kalos","alola"]
    @State private var selectedRegionIndex = 0
    var body: some View {
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    Picker(selection: $selectedRegionIndex, label: Text("")) {
                        ForEach(regions.indices) { (index) in
                            Text(regions[index].capitalized)
                            
                        }
                        
                    }
                    .padding(.top, -50.0)}
                let dataSource = viewModel.location
                
                ForEach(dataSource.filter({ $0.region == regions[selectedRegionIndex]})) { location in
                    
                    LocationCell(location: location)
                        
                        .padding(.horizontal)
                    
                }
            } .onAppear {
                viewModel.fetchLocation()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Pokédex")
            
        }
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView().preferredColorScheme(.dark)
    }
}
