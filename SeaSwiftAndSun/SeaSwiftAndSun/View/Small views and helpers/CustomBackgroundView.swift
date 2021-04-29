//
//  CustomBackgroundView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 29/04/2021.
//

import SwiftUI

struct CustomBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("customLightOrange"), Color("customOrange")]), startPoint: .bottomLeading, endPoint: .topTrailing)
    }
}

struct CustomBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackgroundView()
    }
}
