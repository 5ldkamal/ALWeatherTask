//
//  ALWeatherDetailsViewModel.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public protocol ALWeatherDetailsViewModelProtocol: class {
    var weatherModel: ALWeatherModel { get set }
}

class ALWeatherDetailsViewModel: NSObject , ALWeatherDetailsViewModelProtocol {
    public var weatherModel: ALWeatherModel
    fileprivate let router: KMainRouter
    init(weatherModel: ALWeatherModel, router: KMainRouter) {
        self.router = router
        self.weatherModel = weatherModel
    }
}
