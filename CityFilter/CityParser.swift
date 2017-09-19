//
//  CityParser.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import CoreLocation

class CityParser {
    
    enum Keys {
        static let id = "_id"
        static let country = "country"
        static let name = "name"
        static let coordinate = "coord"
        static let latitude = "lat"
        static let longitude = "lon"
    }
    
    class func parse(data: [String: AnyObject]) -> City? {
        guard
            let id = data[Keys.id] as? Int,
            let country = data[Keys.country] as? String,
            let name = data[Keys.name] as? String,
            let latitude = data[Keys.coordinate]?[Keys.latitude] as? Double,
            let longitude = data[Keys.coordinate]?[Keys.longitude] as? Double
        else {
            return nil
        }
        
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        
        let result = City(
            id: id,
            country: country,
            name: name,
            coordinate: coordinate)
        return result
    }

}
