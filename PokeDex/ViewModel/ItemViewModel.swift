//
//  ItemViewModel.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
let ITEM_DATA_URL = "https://raw.githubusercontent.com/4evernaive/vis2021s/master/do_re_mi.json"
class ItemViewModel: ObservableObject {
    @Published var item = [Item]()
    
    func fetchItem() {
        guard let url = URL(string: ITEM_DATA_URL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard let item = try? JSONDecoder().decode([Item].self, from: data) else { return }

            DispatchQueue.main.async {
                self.item = item
            }
        }.resume()
    }
}
