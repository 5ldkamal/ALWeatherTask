//
//  RepoProtocols.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public protocol WeatherRemoteGetway {
    func fetchWeather(api: RequstBuilderProtocol, completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void)
}

public protocol WeatherGetway {
    func fetchWeather(completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void)
}

public protocol WeatherLocalGetway: WeatherGetway {
    func add(_ weather: ALWeatherModel, completionHandler: @escaping (ResultStatuts<ALWeatherModel>) -> Void)
}

public protocol ALErrorProtocol: class {
    func showError(_ error: ResultError, forHidden hidden: Bool)
}
