//
//  SpotViewModel.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 28/04/2021.
//

import Foundation

class SpotViewModel: ObservableObject {
    private let requestFactory = RequestFactory()
    @Published var spotList: [Spot] = []
    
    init() {
        self.fetchSpot()
    }
    
    func fetchSpot() {
        self.requestFactory.getSpotList { (errorHandle, spots) in
            if let _ = errorHandle.errorType, let errorMessage =
             errorHandle.errorMessage {
                print(errorMessage)
            }
            else if let list = spots {
                DispatchQueue.main.async {
                    self.spotList = list
                }
            }
            else {
                print("Houston we got a problem")
            }
        }
    }
    
    func sendSpot(spot: Spot) {
        let records = Records(spots: [spot])
        self.requestFactory.postSpot(records: records) { (errorHandle) in
            if let _ = errorHandle.errorType, let errorMessage =
             errorHandle.errorMessage {
                print(errorMessage)
            }
            else {
                print("success")
            }
        }
    }
    
    func createSpot(name: String) {
        let fields = Fields(name: name, location: "San Diego, California", photos: nil)
        let spot = Spot(fields: fields)
        self.sendSpot(spot: spot)
    }
}
