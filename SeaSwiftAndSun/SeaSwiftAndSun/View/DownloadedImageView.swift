//
//  DownloadedImageView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 09/04/2021.
//

import SwiftUI

struct DownloadedImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage(named: "surfSpot") ?? UIImage()
    
    init(url: String) {
        imageLoader = ImageLoader(urlString: url)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
            .clipShape(Capsule())
    }
}
