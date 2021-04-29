//
//  AddSpotView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 29/04/2021.
//

import SwiftUI

struct AddSpotView: View {
    @State var spotName: String = ""
    @State var spotLocation: String = ""
    @State var spotBreak: SurfBreak = SurfBreak.beach
    @ObservedObject var viewModel = SpotViewModel()
    
    var body: some View {
        VStack {
            Text("Add a new spot")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("customOrange"))
                .bold()
            TextField("Enter a spot name...", text: $spotName)
                .underlineTextField()
            TextField("Enter a spot location...", text: $spotLocation)
                .underlineTextField()
            // This code is not working on simulator, no reason why...
//            Picker("Choose a Surf Break", selection: $spotBreak) {
//                ForEach(SurfBreak.allCases, id: \.self) {
//                    Text($0.rawValue)
//                }
//            }
            Button("Add") {
                self.viewModel.createSpot(name: self.spotName, location: self.spotLocation, surfBreak: self.spotBreak)
            }
            .font(.title3)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color("customOrange"))
            .accentColor(.white)
            .cornerRadius(40.0)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                .stroke(Color.white, lineWidth: 5))
        }
        .padding()
    }
}

struct AddSpotView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpotView()
    }
}
