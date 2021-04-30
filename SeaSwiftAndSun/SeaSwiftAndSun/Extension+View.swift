//
//  Extension+View.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 29/04/2021.
//

import SwiftUI

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(Color("customOrange"))
            .padding(10)
    }
}

extension Alert {
    public init(message: String? = nil, isError: Bool) {
        var titleText = Text("Error")
        if !isError {
            titleText = Text("Success")
            self.init(title: titleText, message: Text(message ?? ""), dismissButton: .none)
        }
        else {
            self.init(title: titleText, message: Text(message ?? ""), dismissButton: .cancel(Text("Ok")))
        }
    }
}
