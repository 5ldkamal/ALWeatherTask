//
//  ALWeatherDetailsController.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

class ALWeatherDetailsController: UIViewController {
    // MARK: - Properities

    /// Outlet
    @IBOutlet private var cityLbl: UILabel?
    @IBOutlet private var countryLbl: UILabel?
    @IBOutlet private var tempLbl: UILabel?
    @IBOutlet private var stateLbl: UILabel?
    @IBOutlet private var suntriseLbl: UILabel?
    @IBOutlet private var sunsetLbl: UILabel?
    @IBOutlet private var humditytLbl: UILabel?
    @IBOutlet private var pressureLbl: UILabel?
    @IBOutlet private var windLbl: UILabel?
    @IBOutlet private var feeliskeLbl: UILabel?
    /// ViewModel
    var viewModel: ALWeatherDetailsViewModelProtocol?

    // MARK: - Method

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

private extension ALWeatherDetailsController {
    func updateUI() {
        guard let data = viewModel?.weatherModel else {
            return
        }
        cityLbl?.text = data.area.city
        countryLbl?.text = data.area.country
        tempLbl?.text = data.weather.temp
        stateLbl?.text = data.weather.weatherDescription
        suntriseLbl?.text = data.weather.sunrise
        sunsetLbl?.text = data.weather.sunset
        humditytLbl?.text = data.weather.humidity
        pressureLbl?.text = data.weather.pressure
        windLbl?.text = data.weather.wind
        feeliskeLbl?.text = data.weather.feelsLike
    }
}
