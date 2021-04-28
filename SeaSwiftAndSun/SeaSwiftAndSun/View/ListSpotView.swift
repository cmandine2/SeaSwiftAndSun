//
//  ListSpotView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 09/04/2021.
//

import SwiftUI

struct ListSpotView: View {
    var body: some View {
        NavigationView {
            List(spotList.spots, id: \.name) { spot in
                NavigationLink(
                    destination: SpotDetailView(spot: spot)) {
                    SpotRowView(spot: spot)
                }                
            }.listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle("Spot list")
    }
}

struct ListSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ListSpotView()
    }
}
