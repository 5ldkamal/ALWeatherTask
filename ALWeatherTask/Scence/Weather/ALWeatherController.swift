//
//  ALWeatherController.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/20/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

class ALWeatherController: UIViewController {
    // MARK: - Properities

    /// Outlet
    @IBOutlet var tableView: UITableView?
    /// ViewModel
    var viewModel: ALWeatherViewModelProtocol?

    // MARK: - Method

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension ALWeatherController {
    func updateUI() {
//        tableView?.delegate = self
        tableView?.dataSource = self

        viewModel?.loadWeather()
        viewModel?.isReloaded.binding { [weak self] _ in
            guard let self = self else { return }
            self.tableView?.reloadData()
        }
    }
}

extension ALWeatherController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = WeatherTableViewCell.instance(tableView)
        cell.temp = viewModel?.itemForIndexPath(indexPath)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(section: section) ?? 0
    }
}
