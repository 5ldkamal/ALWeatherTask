//
//  Errors.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public protocol Localized {
    var localized: String { get }
}

public enum WeatherErrors: Localized {
    case failedRetrieveDatabase
    case failedAddToDataBase

    public var localized: String {
        switch self {
        case .failedAddToDataBase:
            return "Failed adding the weather in the database"
        case .failedRetrieveDatabase:
            return "Failed retrieving Weather the data base"
        }
    }
}
