//
//  LocationCell.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI

struct LocationCell: View {
    let location: Location
    let viewModel: LocationCellViewModel
    
    init(location: Location) {
        self.location = location
        self.viewModel = LocationCellViewModel(location: location)
    }
    
    var body: some View {
        ZStack {
            VStack{
                Text(self.location.name.capitalized).font(Font.custom("pixelmix", size: 16)).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                Text("Generation: "+self.location.generation).font(Font.custom("pixelmix", size: 12)).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 3)
                    
                HStack {
                    Text(String(location.region.capitalized))
                        .font(Font.custom("pixelmix", size: 12))
                        .font(.subheadline).bold()
                        
                        .foregroundColor(.white)
                        .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.25)))
                        .frame(width: 160, height: 24)
                }
            }.padding(.top, 4) .frame(width: 310, height: 100)
        }
        .padding(.horizontal)
        .background(Color(viewModel.backgroundColor))
        .cornerRadius(12)
        .shadow(color: Color(viewModel.backgroundColor), radius: 6, x: 0, y: 0)
    }
    
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationCell(location:SAMPLE_LOCATION).preferredColorScheme(.dark)
    }
}
