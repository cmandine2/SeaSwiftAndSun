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
        VStack(alignment: .center) {
            MapView(locationStr: self.spot.location)
                .frame(height: 300)
            DownloadedImageView(url: self.spot.imageUrl)
                            .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 3)
                    .frame(width:200, height: 200)
                    .padding(.top, -400)
            VStack {
                Text(self.spot.name)
                    .font(.title)
                Text(self.spot.location)
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

struct SpotDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpotDetailView(spot: Spot(name: "Spot", location: "St Seb", imageUrl: ""))
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
