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
    @Published var alertToDisplay: (Bool, Bool, String) = (false, false,"")
    @Published var loaderToDisplay: Bool = false
    
    init() {
        self.fetchSpot()
    }
    
    //MARK: - Requests
    func fetchSpot() {
        self.loaderToDisplay = true
        self.requestFactory.getSpotList { (errorHandle, spots) in
            DispatchQueue.main.async {
                self.loaderToDisplay = false
                if let _ = errorHandle.errorType, let errorMessage =
                 errorHandle.errorMessage {
                    print(errorMessage)
                    self.displayAlert(error: errorHandle.errorType, message: errorMessage)
                }
                else if let list = spots {
                    self.spotList = self.groupSpots(spots: list)
                }
                else {
                    print("Houston we got a problem")
                    self.displayAlert(error: CustomError.otherError, message: nil)
                }
            }
        }
    }
    
    func sendSpot(spot: Spot) {
        let records = Records(spots: [spot])
        self.loaderToDisplay = true
        self.requestFactory.postSpot(records: records) { (errorHandle) in
            DispatchQueue.main.async {
                self.loaderToDisplay = false
                if let _ = errorHandle.errorType, let errorMessage =
                 errorHandle.errorMessage {
                    print(errorMessage)
                    self.displayAlert(error: errorHandle.errorType, message: errorMessage)
                }
                else {
                    print("success")
                    self.displayAlert(error: nil, message: "Your Spot has been added!")
                }
            }
        }
    }
    
    //MARK: - Helpers
    func createSpot(name: String, location: String, surfBreak: SurfBreak) {
        let fields = Fields(name: name, location: location, photos: nil, surfBreak: [surfBreak.rawValue])
        let spot = Spot(fields: fields)
        self.sendSpot(spot: spot)
    }
    
    private func groupSpots(spots: [Spot]) -> [String: [Spot]] {
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
    
    private func displayAlert(error: CustomError?, message: String?) {
        if error != nil && error == CustomError.requestError {
            self.alertToDisplay = (true, true, "Houston we got a problem")
        }
        else {
            self.alertToDisplay = (true, error != nil, message ?? "Houston we got a problem")
        }
    }

}
