//
//  SpotRowView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 09/04/2021.
//

import SwiftUI

struct SpotRowView: View {
    var spot: Spot
    
    
    var body: some View {
        HStack {
            DownloadedImageView(url: spot.fields.photos?.first?.imageUrl ?? "")
                .overlay(Circle().stroke(Color("customOrange"), lineWidth: 2))
                    .shadow(radius: 1)
                .frame(width: 60, height: 60)
                .padding()
            Text(self.spot.fields.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color("customOrange"))
            Spacer()
        }
        .cornerRadius(5.0)
    }
}

struct SpotRowView_Previews: PreviewProvider {
    static var previews: some View {
        SpotRowView(spot: spotList.spots[0])
            .previewLayout(.fixed(width: 300, height: 90))
    }
}
