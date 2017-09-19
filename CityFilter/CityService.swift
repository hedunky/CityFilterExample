//
//  CityService.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import Foundation

class CityService {
    
    // MARK: - Definitions
    
    typealias CityCompletionBlock = (_ cities: [City]) -> ()
    
    // MARK: - Fields
    
    static let instance = CityService()
    private var cities: [City] = []
    
    // MARK: - Methods
    
    func obtainCities(completion: @escaping CityCompletionBlock) {
        if !cities.isEmpty {
            dispatchCompletion(completion)
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            guard
                let path = Bundle.main.url(forResource: "cities", withExtension: "json")
                else {
                    self.dispatchCompletion(completion)
                    return
            }
            
            do {
                let jsonData = try Data(contentsOf: path, options: .mappedIfSafe)
                guard
                    let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String : AnyObject]]
                    else {
                        self.dispatchCompletion(completion)
                        return
                }
                
                var result: [City] = []
                for object in jsonArray {
                    if let city = CityParser.parse(data: object) {
                        result.append(city)
                    }
                }
                
                self.cities = result
                self.dispatchCompletion(completion)
            } catch {
                self.dispatchCompletion(completion)
            }
        }
    }
    
    private func dispatchCompletion(_ completion: @escaping CityCompletionBlock) {
        DispatchQueue.main.async {
            completion(self.cities)
        }
    }
}
