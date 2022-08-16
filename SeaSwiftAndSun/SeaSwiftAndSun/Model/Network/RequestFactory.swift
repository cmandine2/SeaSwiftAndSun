//
//  RequestFactory.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 28/04/2021.
//

import Foundation
import Combine

fileprivate let API_URL_SPOT = "https://api.airtable.com/v0/appxT9ln6ixuCb3o1/Surf%20Destinations"

enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
    case otherError
}

enum RestMethod: String {
    case GET
    case DELETE
    case POST
}

//MARK: - Request Factory

struct RequestFactory {
    private func createRequest(urlStr: String, parameter: String? = nil, restMethod: RestMethod, bodyData: Data? = nil) -> URLRequest {
        var urlStr = urlStr
        if let parameter = parameter {
            urlStr += parameter
        }
        let url = URL(string: urlStr)!

        var request = URLRequest(url: url)
        request.httpMethod = restMethod.rawValue
        request.timeoutInterval = 100
        
        if let data = bodyData {
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let accessToken = "keymaCPSexfxC2hF9"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        return request
    }
    
    
    func getSpotList(callback: @escaping ((errorType: CustomError?,
                                                                errorMessage: String?),
                                                               [Spot]?) -> Void) {
        let session = URLSession(configuration: .default)        
        let task = session.dataTask(with: createRequest(urlStr: API_URL_SPOT,
                                                        restMethod: .GET)) { (data, response, error) in
            guard let data = data, error == nil else {
                callback((CustomError.requestError, error.debugDescription), nil)
                return
            }
            guard let responseHttp = response as? HTTPURLResponse else {
                callback((CustomError.requestError, "not a http request"), nil)
                return
            }
            guard responseHttp.statusCode == 200 else {
                callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                return
            }
            
            guard let responseJSON = try? JSONDecoder().decode(Records.self, from: data) else {
                callback((CustomError.parsingError, "parsing error"), nil)
                return
            }
            callback((nil, nil), responseJSON.spots)
        }
        task.resume()
    }

    func postSpot(records: Records, callback: @escaping ((errorType: CustomError?, errorMessage: String?)) -> Void) {
        let bodyData = try? JSONEncoder().encode(records)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: API_URL_SPOT,
                                                        restMethod: .POST,
                                                        bodyData: bodyData)) { (data, response, error) in
            
            guard let _ = data, error == nil else {
                callback((CustomError.requestError, error.debugDescription))
                return
            }
            guard let responseHttp = response as? HTTPURLResponse else {
                callback((CustomError.requestError, "not a http request"))
                return
            }
            guard responseHttp.statusCode == 200 else {
                callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"))
                return
            }
            
            callback((nil, nil))
        }
        task.resume()
    }
    
}
