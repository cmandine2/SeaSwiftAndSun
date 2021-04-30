//
//  ActivityIndicatorView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 30/04/2021.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    @Binding var shouldAnimate: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
}

extension View {
    func activityIndicator(isPresented: Binding<Bool>) -> some View {
        return overlay(
            ActivityIndicatorView(shouldAnimate: isPresented)
        )
    }
}
