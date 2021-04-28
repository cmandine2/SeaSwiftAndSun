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
            DownloadedImageView(url: spot.imageUrl)
                .frame(width: 70, height: 70)
            Text(spot.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color.purple)
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
