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
    init(area : ALWArea , weather: ALWweather) {
        self.area = area
        self.weather = weather
    }
}

// MARK: - Current WEAther

public struct ALWweather {
    public let main, weatherDescription, icon: String
    public let date: String
    public let temp, feelsLike, tempMin, tempMax: String
    public let pressure, humidity, seaLevel, grndLevel: String
    init(_ response: WeatherReponseModel) {
        temp = (response.main?.temp ?? 0.0).toString
        feelsLike = (response.main?.feelsLike ?? 0.0).toString
        tempMin = (response.main?.tempMin ?? 0.0).toString
        tempMax = (response.main?.tempMax ?? 0.0).toString
        pressure = (response.main?.pressure ?? 0).toString
        humidity = (response.main?.humidity ?? 0).toString
        seaLevel = (response.main?.seaLevel ?? 0).toString
        grndLevel = (response.main?.grndLevel ?? 0).toString
        date = "\(Date())"
        main = response.weather?.first?.main ?? ""
        weatherDescription = response.weather?.first?.weatherDescription ?? ""
        icon = String(format: WeatherURLS.imageUrl, response.weather?.first?.icon ?? "")
    }

    init(main: String?, weatherDescription: String?, icon: String?, date: String?, temp: String?, feelsLike: String?, tempMin: String?, tempMax: String?, pressure: String?, humidity: String?, seaLevel: String?, grndLevel: String?) {
        self.temp = temp ?? "0.0"
        self.feelsLike = feelsLike ?? "0.0"
        self.tempMin = tempMin ?? "0.0"
        self.tempMax = tempMax ?? "0.0"
        self.pressure = pressure ?? "0"
        self.humidity = humidity ?? "0"
        self.seaLevel = seaLevel ?? "0"
        self.grndLevel = grndLevel ?? "0"
        self.date =  date ?? ""
        self.main = main ?? ""
        self.weatherDescription = weatherDescription ?? ""
        self.icon = icon ?? ""
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

    init(_ city: String, country: String, timezone: Int, lat: Double, log: Double) {
        self.city = city
        self.country = country
        self.timezone = timezone
        self.location = CLLocationCoordinate2D(latitude: lat, longitude: log)
    }
}
