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
    var currentWeather: Boxing<ALWeatherModel?> { get set }
    var numberOfSections: Int { get
    }
    var isReloaded: Boxing<Bool> { get set }
    var isSaved: Boxing<State?> { get set }
    func titleForSection(section: Int) -> String?
    func numberOfItems(section: Int) -> Int
    func itemForIndexPath(_ indexPath: IndexPath) -> ALWeatherModel
    func selectItemForIndex(_ indexPath: IndexPath)

    func loadWeather()
    func save()
}

final class ALWeatherViewModel: BaseViewModel, ALWeatherViewModelProtocol {
    public var currentWeather: Boxing<ALWeatherModel?> = Boxing(nil)
    public var isReloaded: Boxing<Bool> = Boxing(false)
    public var isSaved: Boxing<State?> = Boxing(nil)
    fileprivate var sections: [WeatherSection] = []
    fileprivate let repo: WeatherRepoProtocol
    fileprivate let location: BLocationRepoProtocol
    fileprivate let router: MainRouter
    init(_ repo: WeatherRepoProtocol, location: BLocationRepoProtocol, router: MainRouter) {
        self.repo = repo
        self.location = location
        self.router = router
        super.init()
        self.repo.delegate = self
        self.location.delegate = self
    }

    func loadWeather() {
        /// Load Local
        repo.loadLocalWeather()
        /// Get Location
        location.getLocation()
    }
}

// MARK: - Repo Handler

extension ALWeatherViewModel: WeatherRepoOutPutProtocol {
    func currentWeaather(_ weather: [ALWeatherModel]) {
        let current = WeatherSection(title: "Current Weather", items: weather)
        sections.insert(current, at: 0)
        isReloaded.value = true
        currentWeather.value = weather.first
    }

    func presvoisWeather(_ weather: [ALWeatherModel]) {
        let prev = WeatherSection(title: "Previous Weather", items: weather)
        sections.append(prev)
        isReloaded.value = true
        print(prev)
    }

    func save() {
        guard let value = currentWeather.value else { return }
        repo.saveWeather(value)
    }

    func savedWeather(_: ALWeatherModel) {
        isReloaded.value = true
        isSaved.value = State(messge: "Saved Successfully", state: true)
    }
}

// MARK: - Location Handler

extension ALWeatherViewModel: BLocationOutRepoDelegate {
    func location(_ location: CLLocationCoordinate2D) {
        repo.loadRemoteWeather(location)
    }

    func locationFailed() {
        showError(ResultError.location("Location Denied"), forHidden: false)
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
        router.trigger(destaintion: .details(item))
    }
}

///
public struct WeatherSection {
    let title: String
    let items: [ALWeatherModel]
}

public struct State {
    let messge: String
    let state: Bool
}
