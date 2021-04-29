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
}
