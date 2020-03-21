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

final class ALWeatherDetailsViewModel: NSObject, ALWeatherDetailsViewModelProtocol {
    public var weatherModel: ALWeatherModel
    fileprivate let router: MainRouter
    init(weatherModel: ALWeatherModel, router: MainRouter) {
        self.router = router
        self.weatherModel = weatherModel
    }
}
