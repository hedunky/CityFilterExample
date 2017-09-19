//
//  CityListViewController.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCities()
    }
    
    // MARK: - Helpers
    
    private func prepareCities() {
        activityIndicatorView.startAnimating()
        CityService.instance.obtainCities(completion: { [weak self] (cities: [City]) in
            guard let controller = self else { return }
            controller.activityIndicatorView.stopAnimating()
        })
    }

}
