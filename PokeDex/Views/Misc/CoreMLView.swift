//
//  CoreMLView.swift
//  PokeDex
//
//  Created by Vesper Lee on 22/6/2021.
//


import SwiftUI

struct CoreMLView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            imageView(for: viewModel.selectedImage)

            controlBar()
        }
        .fullScreenCover(isPresented: $viewModel.isPresentingImagePicker, content: {
            ImagePicker(sourceType: viewModel.sourceType, completionHandler: viewModel.didSelectImage)
        })
    }
    
    @ViewBuilder
    func imageView(for image: UIImage?) -> some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
            //let hama =
            Text(ImageClassification(image: image)).font(Font.custom("pixelmix", size: 16))
        }
        else {
            Text("No Pokemon's image selected").font(Font.custom("pixelmix", size: 16))
        }
    }
    
    func controlBar() -> some View {
        HStack(spacing: 32) {
            Button(action: viewModel.choosePhoto, label: {
                Text("Choose Photo").font(Font.custom("pixelmix", size: 16)) .foregroundColor(.white)
                    .padding(.init(top: 8, leading: 24, bottom: 8, trailing: 24))
                    .background(Color(red: 323/255, green: 32/255, blue: 64/255))
                    .cornerRadius(20)
            })
        }.padding()
    }
}


private func ImageClassification(image: UIImage) -> String{
    let myImageModel = PokemonClassifier()
    let resizedImage = image.resizeTo(size:CGSize(width: 227, height: 227))
    let buffer = resizedImage!.toBuffer()!
    let myOutput = try?myImageModel.prediction(image: buffer)
    
    if let myOutput = myOutput{
        let results = myOutput.classLabelProbs.sorted(by:{$0.1>$1.1})
        let result = results.map{(key,value) in return "\(key)=\(value*100)%"}.joined(separator: "\n")
        return result
    }
    return "0"
}


extension CoreMLView {
    final class ViewModel: ObservableObject {
        @Published var selectedImage: UIImage?
        @Published var isPresentingImagePicker = false
        private(set) var sourceType: ImagePicker.SourceType = .camera
        
        func choosePhoto() {
            sourceType = .photoLibrary
            isPresentingImagePicker = true
        }
       
        func didSelectImage(_ image: UIImage?) {
            selectedImage = image
            isPresentingImagePicker = false
        }
    }
}

struct CoreMLView_Previews: PreviewProvider {
    static var previews: some View {
        CoreMLView().preferredColorScheme(.dark)
    }
}
