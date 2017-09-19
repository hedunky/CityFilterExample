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
    
    func testWithoutFilter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "AU", name: "Sydney")
        let city3 = city(country: "AS", name: "Arizona")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3])
        XCTAssert(dataSource.cities.count == 3)
        XCTAssert(dataSource.cities[0] === city1)
        XCTAssert(dataSource.cities[1] === city3)
        XCTAssert(dataSource.cities[2] === city2)
    }
    
    func testWithEmptyFilter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "AU", name: "Sydney")
        let city3 = city(country: "AS", name: "Arizona")
        let city4 = city(country: "FR", name: "Paris")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4])
        dataSource.filterByPrefix("")
        XCTAssert(dataSource.cities.count == 4)
        XCTAssert(dataSource.cities[0] === city1)
        XCTAssert(dataSource.cities[1] === city3)
        XCTAssert(dataSource.cities[2] === city4)
        XCTAssert(dataSource.cities[3] === city2)
    }
    
    func testExampleOneLetter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("A")
        XCTAssert(dataSource.cities.count == 4)
        XCTAssert(dataSource.cities[0] === city1)
        XCTAssert(dataSource.cities[1] === city2)
        XCTAssert(dataSource.cities[2] === city3)
        XCTAssert(dataSource.cities[3] === city4)
    }
    
    func testExampleOneLetterOneResult() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("S")
        XCTAssert(dataSource.cities.count == 1)
        XCTAssert(dataSource.cities[0] === city5)
    }
    
    func testExampleTwoLetters() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("al")
        XCTAssert(dataSource.cities.count == 2)
        XCTAssert(dataSource.cities[0] === city1)
        XCTAssert(dataSource.cities[1] === city2)
    }
    
    func testExampleThreeLetters() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("alB")
        XCTAssert(dataSource.cities.count == 1)
        XCTAssert(dataSource.cities[0] === city2)
    }
    
    func testOneLetterFilter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2])
        dataSource.filterByPrefix("A")
        XCTAssert(dataSource.cities.count == 1)
        XCTAssert(dataSource.cities[0] === city1)
    }
    
    func testNumberFilter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2])
        dataSource.filterByPrefix("7")
        XCTAssert(dataSource.cities.count == 0)
    }
    
    func testLongFilter() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("alabamaa")
        XCTAssert(dataSource.cities.count == 0)
    }
    
    func testExactOccurence() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Sydney")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("sydney")
        XCTAssert(dataSource.cities.count == 1)
        XCTAssert(dataSource.cities[0] === city5)
    }
    
    func testSameCityNames() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Albuquerque")
        let city3 = city(country: "US", name: "Anaheim")
        let city4 = city(country: "AS", name: "Arizona")
        let city5 = city(country: "AU", name: "Alabama")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5])
        dataSource.filterByPrefix("Alabama")
        XCTAssert(dataSource.cities.count == 2)
        XCTAssert(dataSource.cities[0] === city5)
        XCTAssert(dataSource.cities[1] === city1)
    }
    
    func testOccurenceFromMiddle() {
        let city1 = city(country: "US", name: "Alabama")
        let city2 = city(country: "US", name: "Alabbama")
        let city3 = city(country: "US", name: "Aladama")
        let city4 = city(country: "US", name: "Alamama")
        let city5 = city(country: "US", name: "Alamara")
        let city6 = city(country: "US", name: "Alayma")
        
        let dataSource = CityDataSource(cities: [city1, city2, city3, city4, city5, city6])
        dataSource.filterByPrefix("alama")
        XCTAssert(dataSource.cities.count == 2)
        XCTAssert(dataSource.cities[0] === city4)
        XCTAssert(dataSource.cities[1] === city5)
    }
    
    // MARK: - Helpers
    
    private func city(country: String, name: String) -> City {
        let coordinate = CLLocationCoordinate2DMake(0, 0)
        let result = City(id: 0, country: country, name: name, coordinate: coordinate)
        return result
    }
}
