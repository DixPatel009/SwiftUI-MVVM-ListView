//
//  ImageLoader.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    
    func load(fromURL url: String) {
        
        if url == "" { return }
        
        APIService.shared.downloadImage(from: url) { uiImage in
            guard let uiImage = uiImage else { return }
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}
