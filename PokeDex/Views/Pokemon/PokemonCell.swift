//
//  PokemonCell.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI
import Kingfisher

struct PokemonCell: View {
    let pokemon: Pokemon
    let viewModel: PokemonCellViewModel

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.viewModel = PokemonCellViewModel(pokemon: pokemon)
    }
    
    var body: some View {
        ZStack {
            VStack() {
                VStack{
                    KFImage(URL(string: self.pokemon.front_imageUrl))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                        .offset(y:10)
                }
               
                Text(self.pokemon.name.capitalized).font(Font.custom("pixelmix", size: 12)).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                   
               
                Text("#"+String(self.pokemon.id)).font(Font.custom("pixelmix", size: 8)).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, -90)
                    .padding(.leading, 70)
                   
            
            }
        }.frame(width: 110, height: 110)
        .background(Color(viewModel.backgroundColor))
        .cornerRadius(12)
        .shadow(color: Color(viewModel.backgroundColor), radius: 6, x: 0, y: 0)
    }
}

struct PokemonCell_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCell(pokemon: SAMPLE_POKEMONB).preferredColorScheme(.dark)
    }
}
