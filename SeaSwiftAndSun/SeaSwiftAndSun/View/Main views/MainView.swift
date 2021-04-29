//
//  MainView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 29/04/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ListSpotView()
                .tabItem {
                    Image("listPicto").renderingMode(.template)
                    Text("List")
                }
            AddSpotView()
                .tabItem {
                    Image("addPicto").renderingMode(.template)
                    Text("Add")
                }
        }
        .accentColor(Color("customGreen"))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
