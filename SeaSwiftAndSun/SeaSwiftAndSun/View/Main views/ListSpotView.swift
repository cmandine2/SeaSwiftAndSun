//
//  ListSpotView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 09/04/2021.
//

import SwiftUI
import UIKit

struct ListSpotView: View {
    @ObservedObject var viewModel = SpotViewModel()
    
    init(){
        let contentView = UIHostingController(rootView: CustomBackgroundView())
        UITableView.appearance().backgroundView = contentView.view
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.surfBreak, id: \.self) { key in
                    Section(header: Text(key).font(.subheadline).foregroundColor(.white)) {
                        if let spotList: [Spot] = viewModel.spotList[key] {
                            ForEach(spotList, id: \.id) { spot in
                                NavigationLink(
                                    destination: SpotDetailView(spot: spot)) {
                                    SpotRowView(spot: spot)
                                        .frame(height: 75)
                                }
                            }
                        }

                    }
                }
            }.listStyle(InsetGroupedListStyle())
            .navigationTitle("Spot list")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.black)
    }
}

struct ListSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ListSpotView()
    }
}
