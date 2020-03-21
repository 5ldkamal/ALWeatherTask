//
//  WeatherRemoteRepo.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

final class WeatherRemoteRepo: NSObject, WeatherRemoteGetway {
    func fetchWeather(api: RequstBuilderProtocol, completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void) {
        api.requst(model: WeatherReponseModel.self) { result in
            switch result {
            case let .sucess(model):
                completionHandler(ResultStatuts.sucess([ALWeatherModel(model)]))
            case let .failure(error):
                completionHandler(ResultStatuts.failure(error))
            }
        }
    }
}
