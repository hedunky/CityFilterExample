//
//  CityDataSource.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit

class CityDataSource {
    
    // MARK: - Fields
    
    var cities: [City] = []
    var words: [String] = []
    
    // MARK: - Private fields
    
    let trie = Trie()
    private let allCities: [City]
    
    // MARK: - Constructors
    
    init(cities: [City]) {
        self.allCities = cities
        for city in cities {
            trie.addWord(keyword: city.name)
        }
    }
    
    // MARK: - Filtering
    
    func filterByPrefix(_ prefix: String) {
        cities = [allCities[1]]
        words = trie.findWord(keyword: prefix)
    }
}
