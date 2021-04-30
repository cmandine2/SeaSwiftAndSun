//
//  ListSpotView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 09/04/2021.
//

import SwiftUI
import UIKit
import SwiftUIRefresh

struct ListSpotView: View {
    @ObservedObject var viewModel = SpotViewModel()
    @State private var pullIsShowing = false
    
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
            .pullToRefresh(isShowing: self.$pullIsShowing) {
                self.viewModel.fetchSpot()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.pullIsShowing = false
                }
            }
            .onChange(of: self.pullIsShowing) { value in
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert(isPresented: self.$viewModel.alertToDisplay.0, content: {
            return Alert(message: self.viewModel.alertToDisplay.2, isError: self.viewModel.alertToDisplay.1)
        })
        .activityIndicator(isPresented: self.$viewModel.loaderToDisplay)
    }
}

struct ListSpotView_Previews: PreviewProvider {
    static var previews: some View {
        ListSpotView()
    }
}
