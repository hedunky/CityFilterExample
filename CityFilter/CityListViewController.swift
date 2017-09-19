//
//  CityListViewController.swift
//  CityFilter
//
//  Created by Alexander Kurbanov on 19/09/2017.
//  Copyright © 2017 Alexander Kurbanov. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Fields
    
    private var dataSource = CityDataSource(cities: [])
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCities()
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.filterByPrefix(searchText)
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let result = dataSource.cities.count
        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let city = dataSource.cities[indexPath.row]
        
        cell.textLabel?.text = city.displayName()
        return cell
    }
    
    // MARK: - Helpers
    
    private func prepareCities() {
        activityIndicatorView.startAnimating()
        tableView.isHidden = true
        
        CityService.instance.obtainCities(completion: { [weak self] (cities: [City]) in
            guard let controller = self else { return }
            DispatchQueue.global(qos: .utility).async {
                controller.dataSource = CityDataSource(cities: cities)
                DispatchQueue.main.async {
                    controller.activityIndicatorView.stopAnimating()
                    controller.dataSource.filterByPrefix(controller.searchBar.text ?? "")
                    controller.tableView.reloadData()
                    controller.tableView.isHidden = false
                }
            }
        })
    }

}
