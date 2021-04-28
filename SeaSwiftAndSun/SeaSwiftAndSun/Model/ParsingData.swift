//
//  ParsingData.swift
//  SeaSwiftAndSun
//
//  Created by Amandine Cousin on 30/03/2021.
//

import Foundation

var spotList: Records = ParsingData().load("JsonData.json")

class ParsingData {
    func load(_ filename: String) -> Records {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Records.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Records.self):\n\(error)")
        }
    }
}

