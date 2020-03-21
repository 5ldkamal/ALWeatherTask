//
//  WeatherRemoteRepo.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

class WeatherRemoteRepo: NSObject, WeatherRemoteGetway {

    func fetchWeather(api: KKRequstBuilderProtocol ,completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void) {
        api.requst(model: WeatherReponseModel.self) { result in
            switch result {
            case .sucess(let model):
                completionHandler(ResultStatuts.sucess([ALWeatherModel(model)]))
            case .failure(let error):
                completionHandler(ResultStatuts.failure(error))
            }
        }
    }
}
