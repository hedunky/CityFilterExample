//
//  CityDataSource.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit

private class CitiesByCharacter {
    
    let character: String
    let cities: [City]
    
    init(character: String, cities: [City]) {
        self.character = character
        self.cities = cities
    }
}

class CityDataSource {
    
    // MARK: - Fields
    
    var cities: [City] = []
    
    // MARK: - Private fields
    
    private let allCitiesByCharacter: [CitiesByCharacter]
    
    // MARK: - Constructors
    
    init(cities: [City]) {
        self.allCitiesByCharacter = CityDataSource.createCitiesByCharacter(cities: cities)
        self.filterByPrefix("")
    }
    
    // MARK: - Filtering
    
    func filterByPrefix(_ prefix: String) {
        if prefix.isEmpty {
            var result: [City] = []
            for citiesByCharacter in allCitiesByCharacter {
                result.append(contentsOf: citiesByCharacter.cities)
            }
            self.cities = result
            
        } else {
            let lowercasedPrefix = prefix.lowercased()
            guard let firstCharacter = prefix.characters.first else { return }
            let firstCharacterLowercased = String(firstCharacter).lowercased()
            let citiesByCharacter = allCitiesByCharacter.first(where: { $0.character == firstCharacterLowercased })
            var result: [City] = []
            
            var didFindFirstOccurence = false
            for city in citiesByCharacter?.cities ?? [] {
                if city.name.lowercased().hasPrefix(lowercasedPrefix) {
                    result.append(city)
                    didFindFirstOccurence = true
                } else if didFindFirstOccurence {
                    break
                }
            }
            self.cities = result
        }
    }
    
    // MARK: - Helpers
    
    private static func createCitiesByCharacter(cities: [City]) -> [CitiesByCharacter] {
        var citiesByCharacter: [String : [City]] = [:]
        
        let sortedCities = cities.sorted(by: { $0.displayName() < $1.displayName() })
        for city in sortedCities {
            if let firstCharacter = city.name.characters.first {
                let firstCharacterLowercased = String(firstCharacter).lowercased()
                var array = citiesByCharacter[firstCharacterLowercased] ?? []
                array.append(city)
                citiesByCharacter[firstCharacterLowercased] = array
            }
        }
        
        var result = citiesByCharacter.map({ CitiesByCharacter(character: String($0.key).lowercased(), cities: $0.value) })
        result = result.sorted(by: { $0.character < $1.character })
        return result
    }
}
