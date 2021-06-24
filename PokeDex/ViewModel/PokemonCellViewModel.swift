//
//  File.swift
//  PokeDex
//
//  Created by Vesper Lee on 2021/5/27.
//

import Foundation
import SwiftUI

struct PokemonCellViewModel {
    let pokemon: Pokemon
    
    var typeBackgroundColor: UIColor {
        switch pokemon.type {
        case "fire": return .systemRed
        case "grass","poison", "bug": return .systemGreen
        case "water": return .systemTeal
        case "electric": return .systemYellow
        case "psychic": return .systemPurple
        case "normal": return .systemOrange
        case "ground": return .systemGray
        case "flying": return .systemBlue
        case "fairy": return .systemPink
        default: return .systemIndigo
        }
    }
    
    var backgroundColor: UIColor {
        var rgb_temp = [rgbCO]()
        struct rgbCO: Decodable {
            let id: Int
            let r: Int
            let g: Int
            let b: Int
        }
        do {
            let url = Bundle.main.url(forResource: "rgbJSON", withExtension: "json")!
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode([rgbCO].self, from: data)
            
            // json 資料裝載
            for building in result {
                rgb_temp.append(rgbCO(
                    id: building.id,r: building.r,g: building.g,b: building.b
                ))
            }
        } catch {
            print(error)
        }
        
        return UIColor(red: CGFloat(rgb_temp[pokemon.id-1].r)/255.0, green: CGFloat(rgb_temp[pokemon.id-1].g)/255.0, blue: CGFloat(rgb_temp[pokemon.id-1].b)/255.0, alpha: 1)
    }
    
    
    
   
    func cxg_getPointColor(withImage image: UIImage, point: CGPoint) -> UIColor? {
        
        guard CGRect(origin: CGPoint(x: 0, y: 0), size: image.size).contains(point) else {
            return nil
        }
        
        let pointX = trunc(point.x);
        let pointY = trunc(point.y);
        
        let width = image.size.width;
        let height = image.size.height;
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [0, 0, 0, 0]
        
        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), let cgImage = image.cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        }
        
        let red = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue = CGFloat(pixelData[2]) / CGFloat(255.0)
        let alpha = CGFloat(pixelData[3]) / CGFloat(255.0)
        
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
