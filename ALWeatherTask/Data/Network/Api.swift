//
//  Api.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/2/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import Foundation

enum WeatherURLS {
    static let imageUrl = "http://openweathermap.org/img/w/%@.png"
}

let WEATHERPAIKEY = "5c6ddd7296886691926c98f9420327cd"
enum Api: RequstBuilderProtocol {
    case currentWeatherByLocation(CLLocationCoordinate2D)
    var path: String {
        switch self {
        case let .currentWeatherByLocation(location): return "weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(WEATHERPAIKEY)"
        }
    }
}
