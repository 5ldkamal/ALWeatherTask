//
//  WeatherRepo.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit
import CoreLocation

// MARK: - Input

public protocol WeatherRepoProtocol : class {
    var delegate: WeatherRepoOutPutProtocol? { get set }
    func saveWeather(_ weather: ALWeatherModel)
    func loadLocalWeather()
    func loadremoteWeather(_ location :CLLocationCoordinate2D)
}

// MARK: - Output

public protocol WeatherRepoOutPutProtocol: ALErrorProtocol {
    func currentWeaather(_ weather: [ALWeatherModel])
    func presvoisWeather(_ weather: [ALWeatherModel])
    func savedWeather(_ weather: ALWeatherModel)
}

class WeatherRepo: NSObject, WeatherRepoProtocol {
    public weak var delegate: WeatherRepoOutPutProtocol?
    fileprivate let local: WeatherLocalGetway
    fileprivate let remote: WeatherRemoteGetway
    init(remote: WeatherRemoteGetway, local: WeatherLocalGetway) {
        self.local = local
        self.remote = remote
    }

    func loadremoteWeather(_ location: CLLocationCoordinate2D) {
        /// Load from Remote
        remote.fetchWeather(api: Api.currentWeatherByLocation(location)){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .sucess(let weather): self.delegate?.currentWeaather(weather)
            case .failure(let errro): self.delegate?.showError(errro, forHidden: true)
            }
        }
    }
    func loadLocalWeather() {
        /// Load from DataBase
        local.fetchWeather { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .sucess(let weather): self.delegate?.presvoisWeather(weather)
            case .failure(let errro): self.delegate?.showError(errro, forHidden: true)
            }
        }
    }

    /// Save The current Weather
    func saveWeather(_ weather: ALWeatherModel) {
        local.add(weather) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .sucess(let weather): self.delegate?.savedWeather(weather)
            case .failure(let errro): self.delegate?.showError(errro, forHidden: false)
            }
        }
    }
}
