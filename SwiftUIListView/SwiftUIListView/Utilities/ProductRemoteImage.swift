//
//  ProductRemoteImage.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct ProductRemoteImage: View {
    
    @StateObject private var imageLoader = ImageLoader()
    var urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear { imageLoader.load(fromURL: urlString) }
    }
}
