//
//  WeatherEntity+Extension.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreData
import Foundation

extension WeatherEntity {
    func addRecord(_ weatherModel: ALWeatherModel) {
        country = weatherModel.area.country
        city = weatherModel.area.city
        lat = weatherModel.area.location.latitude
        lon = weatherModel.area.location.longitude
        date = weatherModel.weather.date
        feelsLike = weatherModel.weather.feelsLike
        grndLevel = weatherModel.weather.grndLevel
        humidity = weatherModel.weather.humidity
        pressure = weatherModel.weather.pressure
        seaLevel = weatherModel.weather.seaLevel
        temp = weatherModel.weather.temp
        tempMax = weatherModel.weather.tempMax
        tempMin = weatherModel.weather.tempMin
        timezone = Int64(weatherModel.area.timezone)
        weatherDescription = weatherModel.weather.weatherDescription
        icon = weatherModel.weather.icon
        wind = weatherModel.weather.wind
        sunrise = weatherModel.weather.sunrise
        sunset = weatherModel.weather.sunset
    }

    var weatherModel: ALWeatherModel {
        let area = ALWArea(city ?? "", country: country ?? "", timezone: Int(timezone), lat: lat, log: lon)
        let weather = ALWweather(main: "", weatherDescription: weatherDescription, icon: icon, date: date, temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity, seaLevel: seaLevel, grndLevel: grndLevel, sunrise: sunrise, sunset: sunset, wind: wind)
        return ALWeatherModel(area: area, weather: weather)
    }
}
