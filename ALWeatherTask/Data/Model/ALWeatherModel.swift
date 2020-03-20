//
//  ALWeatherModel.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreLocation
import UIKit

// MARK: - Model

public struct ALWeatherModel {
    let area: ALWArea
    let weather: ALWweather
    init(_ response: WeatherReponseModel) {
        area = ALWArea(response)
        weather = ALWweather(response)
    }
}

// MARK: - Current WEAther

public struct ALWweather {
    public let main, weatherDescription, icon: String
    public let date: String
    public let temp, feelsLike, tempMin, tempMax: Double
    public let pressure, humidity, seaLevel, grndLevel: Int
    init(_ response: WeatherReponseModel) {
        temp = response.main?.temp ?? 0.0
        feelsLike = response.main?.feelsLike ?? 0.0
        tempMin = response.main?.tempMin ?? 0.0
        tempMax = response.main?.tempMax ?? 0.0
        pressure = response.main?.pressure ?? 0
        humidity = response.main?.humidity ?? 0
        seaLevel = response.main?.seaLevel ?? 0
        grndLevel = response.main?.grndLevel ?? 0
        date = "\(Date())"
        main = response.weather?.first?.main ?? ""
        weatherDescription = response.weather?.first?.weatherDescription ?? ""
        icon = String(format: WeatherURLS.imageUrl, response.weather?.first?.icon ?? "")
    }
}

// MARK: - Current Area

public struct ALWArea {
    let city: String
    let country: String
    let timezone: Int
    let location: CLLocationCoordinate2D
    init(_ response: WeatherReponseModel) {
        city = response.name ?? ""
        country = response.sys?.country ?? ""
        timezone = response.timezone ?? 0
        location = CLLocationCoordinate2D(latitude: response.coord?.lat ?? 0, longitude: response.coord?.lon ?? 0)
    }
}
