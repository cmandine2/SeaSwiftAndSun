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
                .tabItem { Text("List") }
            Text("Add")
                .tabItem { Text("Add") }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
