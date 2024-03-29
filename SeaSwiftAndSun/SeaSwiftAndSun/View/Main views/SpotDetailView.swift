//
//  SpotDetailView.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 27/04/2021.
//

import SwiftUI
import MapKit

struct SpotDetailView: View {
    @State var spot: Spot
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                ZStack {
                    DownloadedImageView(url: spot.fields.photos?.first?.imageUrl ?? "")
                                    .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                    .shadow(radius: 3)
                            .frame(width:200, height: 200)
                        .zIndex(1)
                    MapView(locationStr: self.spot.fields.location)
                        .frame(height: 300)
                        .padding(.top, 300)
                }
                .padding(.top, -250)
                VStack {
                    Text(self.spot.fields.name)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color("customOrange"))
                    Text(self.spot.fields.location)
                        .font(.subheadline)
                    Text(self.spot.fields.surfBreak.first!)
                }
                .padding()
            }
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpotDetailView(spot: Spot(id: "1234567890", fields: Fields(name: "Surf spot", location: "Saint sebastien sur loire", photos: [Photo(imageUrl: "")], surfBreak: [SurfBreak.beach.rawValue])))
    }
}


struct MapView: UIViewRepresentable {
    var locationStr: String
    
    func makeUIView(context: Context) -> some MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        GeoCoder().getCoordinates(address: locationStr) { (coordinates) in
            if let coordinates = coordinates {
                let region = MKCoordinateRegion(center: coordinates, span: span)
                uiView.setRegion(region, animated: true)
            }
        }
        
    }
}
