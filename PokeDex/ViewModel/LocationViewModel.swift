//
//  ListViewModel.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
let LOCATION_DATA_URL = "https://firebasestorage.googleapis.com/v0/b/chatbot-108aea001-289606.appspot.com/o/location.json?alt=media&token=e7c33b33-4412-4478-b82d-219a8ff81cb4"
class LocationViewModel: ObservableObject {
    @Published var location = [Location]()
    
    func fetchLocation() {
        guard let url = URL(string: LOCATION_DATA_URL) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                     do {
                         let location = try JSONDecoder().decode([Location].self, from: data)
                        DispatchQueue.main.async {
                            self.location = location
                        }
                     } catch  {
                         print(error)
                     }
                 }
        }.resume()
    }
}
