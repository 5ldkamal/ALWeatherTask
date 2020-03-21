//
//  ALWeatherViewModel.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreLocation
import UIKit
public protocol ALWeatherViewModelProtocol {
    func loadWeather()

    //
    var numberOfSections: Int { get
    }
    var isReloaded: Boxing<Bool> { get set }
    func titleForSection(section: Int) -> String?
    func numberOfItems(section: Int) -> Int
    func itemForIndexPath(_ indexPath: IndexPath) -> ALWeatherModel
    func selectItemForIndex(_ indexPath: IndexPath)
}

class ALWeatherViewModel: BaseViewModel, ALWeatherViewModelProtocol {
    var isReloaded: Boxing<Bool> = Boxing(false)
    fileprivate var sections: [WeatherSection] = []
    fileprivate let repo: WeatherRepoProtocol
    fileprivate let location: BLocationRepoProtocol
    init(_ repo: WeatherRepoProtocol, location: BLocationRepoProtocol) {
        self.repo = repo
        self.location = location
        super.init()
        self.repo.delegate = self
        self.location.delegate = self
    }

    func loadWeather() {
        /// Load Local
        repo.loadLocalWeather()
        /// get Location
        location.getLocation()
    }
}

// MARK: - Repo Handler

extension ALWeatherViewModel: WeatherRepoOutPutProtocol {
    func currentWeaather(_ weather: [ALWeatherModel]) {
        let current = WeatherSection(title: "Current", items: weather)
        sections.insert(current, at: 0)
        isReloaded.value = true
    }

    func presvoisWeather(_ weather: [ALWeatherModel]) {
        let prev = WeatherSection(title: "Current", items: weather)
        sections.append(prev)
        isReloaded.value = true
    }

    func savedWeather(_ weather: ALWeatherModel) {}
}

// MARK: - Location Handler

extension ALWeatherViewModel: BLocationOutRepoDelegate {
    func location(_ location: CLLocationCoordinate2D) {
        repo.loadremoteWeather(location)
    }

    func locationFailed() {
        self.showError(ResultError.location("Location Error"), forHidden: false)
    }
}

// MARK: - Handle UI

extension ALWeatherViewModel {
    var numberOfSections: Int {
        return sections.count
    }

    func titleForSection(section: Int) -> String? {
        return sections[section].title
    }

    func numberOfItems(section: Int) -> Int {
        return sections[section].items.count
    }

    func itemForIndexPath(_ indexPath: IndexPath) -> ALWeatherModel {
        return sections[indexPath.section].items[indexPath.row]
    }

    func selectItemForIndex(_ indexPath: IndexPath) {
        let item = itemForIndexPath(indexPath)
        print(item.area)
    }
}

//
public struct WeatherSection
{
    let title: String
    let items: [ALWeatherModel]
}
