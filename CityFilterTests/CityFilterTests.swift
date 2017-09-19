//
//  CityFilterTests.swift
//  CityFilterTests
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import XCTest
import CoreLocation
@testable import CityFilter

class CityFilterTests: XCTestCase {
    
    // MARK: - Tests
    
    func testOneLetterFilter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2])
        dataSource.filterByPrefix("A")
//        XCTAssert(dataSource.cities.count == 1)
//        XCTAssert(dataSource.cities[0] === city1)
        
        XCTAssert(dataSource.words.count == 1)
        XCTAssert(dataSource.words[0] == "Alabama")
    }
    
    // MARK: - Helpers
    
    private func city(country: String, name: String) -> City {
        let coordinate = CLLocationCoordinate2DMake(0, 0)
        let result = City(id: 0, country: country, name: name, coordinate: coordinate)
        return result
    }
}
