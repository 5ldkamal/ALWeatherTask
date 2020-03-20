//
//  Api.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/2/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation

enum WeatherURLS {
   static let imageUrl = "http://openweathermap.org/img/w/%@.png"
}

let WEATHERPAIKEY = "5c6ddd7296886691926c98f9420327cd"
enum Api: KKRequstBuilderProtocol
{
    case currentWeatherByLocation
    var path: String
    {
        switch self
        {
        case .currentWeatherByLocation: return "weather?lat=31.2&lon=31.2&appid=\(WEATHERPAIKEY)"
        }
    }
}
