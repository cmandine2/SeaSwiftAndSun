//
//  SpotViewModel.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 28/04/2021.
//

import Foundation

class SpotViewModel: ObservableObject {
    private let requestFactory = RequestFactory()
    @Published var spotList: [String:[Spot]] = ["":[]]
    @Published var surfBreak: [String] = []
    @Published var alertToDisplay: Bool = false
    
    init() {
        self.fetchSpot()
    }
    
    //MARK: - Requests
    func fetchSpot() {
        self.requestFactory.getSpotList { (errorHandle, spots) in
            if let _ = errorHandle.errorType, let errorMessage =
             errorHandle.errorMessage {
                print(errorMessage)
                self.alertToDisplay = true
            }
            else if let list = spots {
                DispatchQueue.main.async {
                    self.spotList = self.groupSpots(spots: list)
                }
            }
            else {
                print("Houston we got a problem")
                self.alertToDisplay = true
            }
        }
    }
    
    func sendSpot(spot: Spot) {
        let records = Records(spots: [spot])
        self.requestFactory.postSpot(records: records) { (errorHandle) in
            if let _ = errorHandle.errorType, let errorMessage =
             errorHandle.errorMessage {
                print(errorMessage)
                self.alertToDisplay = true
            }
            else {
                print("success")
            }
        }
    }
    
    //MARK: - Helpers
    func createSpot(name: String, location: String, surfBreak: SurfBreak) {
        let fields = Fields(name: name, location: location, photos: nil, surfBreak: [surfBreak.rawValue])
        let spot = Spot(fields: fields)
        self.sendSpot(spot: spot)
    }
    
    func groupSpots(spots: [Spot]) -> [String: [Spot]] {
        var dico = [String: [Spot]]()
        
        for spot in spots {
            if dico[spot.fields.surfBreak.first!] != nil {
                dico[spot.fields.surfBreak.first!]?.append(spot)
            }
            else {
                dico[spot.fields.surfBreak.first!] = [spot]
                self.surfBreak.append(spot.fields.surfBreak.first!)
            }
        }
        
        return dico
    }
}
