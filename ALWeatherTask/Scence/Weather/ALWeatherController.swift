//
//  ALWeatherController.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/20/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

final class ALWeatherController: UIViewController {
    // MARK: - Properities

    /// Outlet
    @IBOutlet private var tableView: UITableView?
    @IBOutlet private var cityLbl: UILabel?
    @IBOutlet private var countryLbl: UILabel?
    @IBOutlet private var savedBtn: UIButton?
    /// ViewModel
    private(set) var viewModel: ALWeatherViewModelProtocol?

    // MARK: - Method

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    public func setViewModel(viewModel: ALWeatherViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension ALWeatherController {
    func updateUI() {
        tableView?.delegate = self
        tableView?.dataSource = self
        /// Load Data
        viewModel?.loadWeather()
        /// Reload TableView
        viewModel?.isReloaded.binding { [weak self] _ in
            guard let self = self else { return }
            self.reloadTBView()
        }
        /// Current Weather
        viewModel?.currentWeather.binding { [weak self] weather in
            guard let self = self else { return }
            self.updateViews(weather)
        }

        viewModel?.isSaved.binding { [weak self] state in
            guard let self = self else { return }
            self.savedBtn?.isEnabled = false
            AlertBuilder.successAlert(message: state?.messge ?? "").prsentT(from: self)
        }
    }

    private func updateViews(_ weather: ALWeatherModel?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.cityLbl?.text = weather?.area.city
            self.countryLbl?.text = weather?.area.country
        }
    }
}

// MARK: - Actions

extension ALWeatherController
{
    @IBAction func saveAction(_ sender: UIButton) {
        viewModel?.save()
    }
}

extension ALWeatherController: UITableViewDataSource, UITableViewDelegate {
    private func reloadTBView() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView?.reloadData()
        }
    }

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

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.titleForSection(section: section)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectItemForIndex(indexPath)
    }
}
