//
//  ListSpotView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 09/04/2021.
//

import SwiftUI

struct ListSpotView: View {
    @ObservedObject var viewModel = SpotViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.spotList, id: \.id) { spot in
                NavigationLink(
                    destination: SpotDetailView(spot: spot)) {
                    SpotRowView(spot: spot)
                }                
            }.listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Spot list")
        }
    }
}

struct ListSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ListSpotView()
    }
}
