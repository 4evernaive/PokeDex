//
//  ItemCell.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import SwiftUI
import Kingfisher

struct ItemCell: View {
    let item: Item
    let viewModel: ItemCellViewModel
    
    init(item: Item) {
        self.item = item
        self.viewModel = ItemCellViewModel(item: item)
    }
    
    var body: some View {
        ZStack {
            VStack{
                Text(self.item.name.capitalized).font(Font.custom("pixelmix", size: 16)).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 4)
                   
                   
                Text(self.item.description).font(Font.custom("pixelmix", size: 15)).font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 3)
                    
                HStack {
                    KFImage(URL(string: self.item.imageUrl))
                        .resizable()
                        .frame(width: 68, height: 68, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(item.categories.capitalized)
                        .font(Font.custom("pixelmix", size: 12))
                        .font(.subheadline).bold()
                        
                        .foregroundColor(.white)
                        .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.25)))
                        .frame(width: 160, height: 24)
                    
                    
                        
                        
                }
            }.padding(.top, 4) .frame(width: 310, height: 200)
        }
        .padding(.horizontal)
        .background(Color(viewModel.backgroundColor))
        .cornerRadius(12)
        .shadow(color: Color(viewModel.backgroundColor), radius: 6, x: 0, y: 0)
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: SAMPLE_ITEM).preferredColorScheme(.dark)
    }
}
