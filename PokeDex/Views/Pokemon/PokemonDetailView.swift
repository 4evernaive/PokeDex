//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    @State var showingDetail = false
    let pokemon: Pokemon
    let viewModel: PokemonCellViewModel

    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.viewModel = PokemonCellViewModel(pokemon: pokemon)
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(viewModel.backgroundColor), Color.black]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
            
          

            ScrollView {
                HStack{
                    KFImage(URL(string: pokemon.front_imageUrl))
                        .resizable()
                        .frame(width: 200, height: 200)
                    KFImage(URL(string:pokemon.back_imageUrl))  .resizable()
                        .frame(width: 200, height: 200)
                }
                VStack {
                
                    Text(pokemon.name.capitalized + " #"+String(pokemon.id))
                        .padding(.top, 40)
                        .font(Font.custom("pixelmix", size: 30))
                    Spacer()
                    Spacer()
                    HStack{
                    Text(pokemon.type.capitalized)
                        .font(Font.custom("pixelmix", size: 16))
                        .foregroundColor(.white)
                        .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
                        .background(Color(viewModel.typeBackgroundColor))
                        .cornerRadius(20)
                    Button(action: {
                               self.showingDetail.toggle()
                        getThreed(name:pokemon.name.capitalized)
                           }) {
                        Text("AR Mode") .font(Font.custom("pixelmix", size: 16))
                            .foregroundColor(.white)
                            .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
                            .background(Color(viewModel.backgroundColor))
                            .cornerRadius(20)
                           }.sheet(isPresented: $showingDetail) {
                            ARViewIndicator()
                           }
                    }
                    Text(pokemon.description)
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("pixelmix", size: 14))
                        .padding(.horizontal)
                        .frame(width: 400.0)
                        .padding(.top, 12)
                    

                    HStack { Spacer() }
                }
                
                .cornerRadius(40)
                .padding(.top, -50)
                .padding(.horizontal)
                .zIndex(-1)
                Spacer()
                Spacer()
              
              

                BarChartView(pokemon: pokemon)
                    .padding(.trailing)
                    .padding(.top, -16)
                Spacer()
  
            }
        }.padding(.horizontal)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: SAMPLE_POKEMONB).preferredColorScheme(.dark)
    }
}
