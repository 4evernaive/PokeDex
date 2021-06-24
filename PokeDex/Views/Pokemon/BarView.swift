//
//  BarView.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI

struct BarView: View {
    var value: Int = 100
    var title: String = "HP"
    var color: Color = .blue

    var body: some View {

        HStack {
            Text(title)
                .padding(.leading, 32)
                .foregroundColor(.gray)
                .frame(width: 100)
                .font(Font.custom("pixelmix", size: 10))
            HStack {
                Text("\(value)")
                    .frame(width: 40)
                    .padding(.trailing)
                    .font(Font.custom("pixelmix", size: 14))
                ZStack(alignment: .leading) {
                    Capsule()
                        .frame(width: 180, height: 20).animation(.default)
                        .foregroundColor(Color(.systemGray5))

                    Capsule()
                        .frame(width: value > 250 ? CGFloat(180) : CGFloat(value), height: 20).animation(.default)
                        .foregroundColor(color)
                }
                Spacer()
            }.padding(.leading)
        }
    }
}

struct BarChartView: View {
    let pokemon: Pokemon
    var body: some View {
        VStack {
            
            Text("Stats")
                .font(Font.custom("pixelmix", size: 20)).padding(.bottom, 20)
            BarView(value: pokemon.height, title: "Height", color: .orange)
            BarView(value: pokemon.weight, title: "Weight", color: .purple).padding(.bottom, 20)
            Text("Base Stats")
                .font(Font.custom("pixelmix", size: 20)).padding(.bottom, 20)
            BarView(value: pokemon.hp, title: "HP", color: .green)
            BarView(value: pokemon.attack, title: "ATK", color: .red)
            BarView(value: pokemon.defense, title: "DEF", color: .blue)
            BarView(value: pokemon.special_attack, title: "SPD", color: .yellow)
            BarView(value: pokemon.speed, title: "SPE", color: Color(red: 152/255, green: 341/255, blue: 342/255))
            BarView(value: pokemon.hp+pokemon.attack+pokemon.defense+pokemon.special_defense+pokemon.speed, title: "Species strength", color: .pink)
        }.padding()
    }
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
        BarView().preferredColorScheme(.dark)
        BarChartView(pokemon: SAMPLE_POKEMONB).preferredColorScheme(.dark)
    }
}

