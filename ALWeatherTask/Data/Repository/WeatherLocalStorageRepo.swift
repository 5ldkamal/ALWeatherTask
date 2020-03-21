//
//  WeatherLocalStorageRepo.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreData
import Foundation
public protocol ALWeatherLocalStorageProtocol {}

final class ALWeatherLocalStorageRepo: WeatherLocalGetway {
    fileprivate let context: NSManagedObjectContextProtocol
    init(_ context: NSManagedObjectContextProtocol) {
        self.context = context
    }

    func fetchWeather(completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void) {
        if let coreData = try? context.allEntities(withType: WeatherEntity.self) {
            let weatherStatus = coreData.map { $0.weatherModel }
            completionHandler(ResultStatuts.sucess(weatherStatus))
        } else {
            completionHandler(ResultStatuts.failure(ResultError.dataBase(WeatherErrors.failedRetrieveDatabase.localized)))
        }
    }

    func add(_ weather: ALWeatherModel, completionHandler: @escaping (ResultStatuts<ALWeatherModel>) -> Void) {
        guard let entity = context.addEntity(withType: WeatherEntity.self) else {
            completionHandler(ResultStatuts.failure(ResultError.dataBase(WeatherErrors.failedAddToDataBase.localized)))
            return
        }
        entity.addRecord(weather)
        do {
            try context.save()
            completionHandler(ResultStatuts.sucess(weather))
        } catch {
            completionHandler(ResultStatuts.failure(ResultError.dataBase(WeatherErrors.failedAddToDataBase.localized)))
        }
    }
}
