//
//  ALWeatherLocalStorage.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreData
import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }

    var message = ""
}

typealias Result<T> = Swift.Result<T, Error>

public protocol ALWeatherLocalStorageProtocol {}

class ALWeatherLocalStorageRepo {
    fileprivate let context: NSManagedObjectContextProtocol
    init(_ context: NSManagedObjectContextProtocol) {
        self.context = context
    }

    func fetchWeather(completionHandler: @escaping (Result<[ALWeatherModel]>) -> Void) {
        if let coreData = try? context.allEntities(withType: WeatherEntity.self) {
            let weatherStats = coreData.map { $0.weatherModel }
            completionHandler(.success(weatherStats))
        } else {
            completionHandler(.failure(CoreError(message: "Failed retrieving Weather the data base")))
        }
    }

    func add(_ weather: ALWeatherModel, completionHandler: @escaping (Result<ALWeatherModel>) -> Void) {
        guard let entity = context.addEntity(withType: WeatherEntity.self) else {
            completionHandler(.failure(CoreError(message: "Failed adding the weather in the database")))
            return
        }
        entity.addRecord(weather)
        do {
            try context.save()
            completionHandler(.success(weather))
        } catch {
            completionHandler(.failure(CoreError(message: "Failed adding the weather in the database")))
        }
    }
}
