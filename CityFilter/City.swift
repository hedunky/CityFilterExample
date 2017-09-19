//
//  City.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import CoreLocation

class City {
    
    let id: Int
    let country: String
    let name: String
    let coordinate: CLLocationCoordinate2D

    init(
        id: Int,
        country: String,
        name: String,
        coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.country = country
        self.name = name
        self.coordinate = coordinate
    }
}
