//
//  KMainFactory.swift
//  kiddo
//
//  Created by Khaled kamal on 1/7/20.
//  Copyright © 2020 spark-cloud. All rights reserved.
//

import UIKit

protocol MainFactoryProtocol: class {
    func main() -> ALWeatherController
    func details(_ model: ALWeatherModel) -> ALWeatherDetailsController
}

final class MainFactory: MainFactoryProtocol {
    let coordinator: MainRouter
    init(coordinator: MainRouter) {
        self.coordinator = coordinator
    }

    /// Main ViewController
    func main() -> ALWeatherController {
        let local = ALWeatherLocalStorageRepo(CoreDataStackImp.shared.context)
        let remote = WeatherRemoteRepo()
        let repo = WeatherRepo(remote: remote, local: local)
        let location = ALWLocationManger()
        let viewModel = ALWeatherViewModel(repo, location: location, router: coordinator)
        let viewController = ALWeatherController.instanceVc()
        viewController.setViewModel(viewModel: viewModel)
        return viewController
    }

    /// Main ViewController
    func details(_ model: ALWeatherModel) -> ALWeatherDetailsController {
        let viewController = ALWeatherDetailsController.instanceVc()
        let viewModel = ALWeatherDetailsViewModel(weatherModel: model, router: coordinator)
        viewController.setViewModel(viewModel: viewModel)
        return viewController
    }
}
