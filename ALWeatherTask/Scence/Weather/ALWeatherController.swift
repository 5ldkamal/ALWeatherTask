//
//  ALWeatherController.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/20/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

class ALWeatherController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Api.currentWeatherByLocation.requst(model: WeatherReponseModel.self) { result in
            switch result{
            case .sucess(let model):
                print(model.weather)
            case .failure(let error):
                print(error.describtionError)
            }
        }
    }
}
