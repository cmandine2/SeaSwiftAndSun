//
//  RequestFactory.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 28/04/2021.
//

import Foundation
import Combine

fileprivate let API_URL_GET_SPOT = "https://api.airtable.com/v0/appxT9ln6ixuCb3o1/Surf%20Destinations"


enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}

enum RestMethod: String {
    case GET
    case DELETE
    case POST
}

//MARK: - Request Factory

struct RequestFactory {
    private func createRequest(urlStr: String, parameter: String? = nil, restMethod: RestMethod) -> URLRequest {
        var urlStr = urlStr
        if let parameter = parameter {
            urlStr += parameter
        }
        let url = URL(string: urlStr)!

        var request = URLRequest(url: url)
        request.httpMethod = restMethod.rawValue
        request.timeoutInterval = 100
        
        let accessToken = "keyuGTkgeGQoidxs6"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        return request
    }
    
    
    func getSpotList(callback: @escaping ((errorType: CustomError?,
                                                                errorMessage: String?),
                                                               [Spot]?) -> Void) {
        let session = URLSession(configuration: .default)        
        let task = session.dataTask(with: createRequest(urlStr: API_URL_GET_SPOT,
                                                        restMethod: .GET)) { (data, response, error) in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        if let response = try? JSONDecoder().decode(Records.self, from: data) {
                            callback((nil, nil), response.spots)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError, error.debugDescription), nil)
            }
        }
        task.resume()
    }
    
//    func fetchSpotList(callback: @escaping ((errorType: CustomError?,
//                                             errorMessage: String?),
//                                            [Spot]?) -> Void) {
//        URLSession.shared.dataTaskPublisher(for: URL(string: API_URL_GET_SPOT)!)
//            .map { $0.data }
//            .decode(type: Records.self, decoder: JSONDecoder())
//            .replaceError(with: Records(spots: []))
//            .eraseToAnyPublisher()
//            .receive(on: RunLoop.main)
//            .assign(to: \SpotViewModel.records, on: self)
//    }
    
}
