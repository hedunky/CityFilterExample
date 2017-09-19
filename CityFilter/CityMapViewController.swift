//
//  CityMapViewController.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 20/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit
import MapKit

class CityMapViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Fields
    
    var city: City!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        title = city.displayName()
        displayCityOnMap()
    }
    
    // MARK: - Helpers
    
    private func displayCityOnMap() {
        var region = MKCoordinateRegion()
        region.center.latitude = city.coordinate.latitude
        region.center.longitude = city.coordinate.longitude
        region.span.latitudeDelta = 0.001
        region.span.longitudeDelta = 0.001
        mapView.setRegion(region, animated: false)
    }
}
