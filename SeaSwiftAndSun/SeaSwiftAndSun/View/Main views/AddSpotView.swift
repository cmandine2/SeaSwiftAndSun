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
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
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
            Image(uiImage: self.image)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 150)
                            .edgesIgnoringSafeArea(.all)
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                Text("Photo library")
                    .font(.headline)
                    .foregroundColor(Color("customOrange"))
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("customOrange"), lineWidth: 2)
                    )
            }
            Button("Add") {
                self.viewModel.createSpot(name: self.spotName, location: self.spotLocation, surfBreak: self.spotBreak)
            }
            .font(.title3)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20)
            .padding()
            .background(Color("customOrange"))
            .accentColor(.white)
            .cornerRadius(40.0)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                .stroke(Color.white, lineWidth: 5))
        }
        .padding()
        .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
        .alert(isPresented: self.$viewModel.alertToDisplay.0, content: {
            return Alert(message: self.viewModel.alertToDisplay.2, isError: self.viewModel.alertToDisplay.1)
        })
        .activityIndicator(isPresented: self.$viewModel.loaderToDisplay)
    }
}

struct AddSpotView_Previews: PreviewProvider {
    static var previews: some View {
        AddSpotView()
    }
}
