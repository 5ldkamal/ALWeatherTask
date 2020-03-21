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

class MainFactory: MainFactoryProtocol {
    let coordinator: KMainRouter
    init(coordinator: KMainRouter) {
        self.coordinator = coordinator
    }

    /// Main ViewController
    func main() -> ALWeatherController {
        let local = ALWeatherLocalStorageRepo(CoreDataStackImp.shared.context)
        let remote = WeatherRemoteRepo()
        let repo = WeatherRepo(remote: remote, local: local)
        let location = ALWLocationManger()
        let viewModel = ALWeatherViewModel(repo, location: location, router: coordinator)
        let vc = ALWeatherController.instanceVc()
        vc.viewModel = viewModel
        if let vm = vc.viewModel as? ALWeatherViewModel {
            vm += vc
        }
        return vc
    }

    /// Main ViewController
    func details(_ model: ALWeatherModel) -> ALWeatherDetailsController {
        let vc = ALWeatherDetailsController.instanceVc()
        vc.viewModel = ALWeatherDetailsViewModel(weatherModel: model, router: coordinator)
        return vc
    }
}
