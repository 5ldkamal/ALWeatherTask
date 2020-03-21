//
//  ALWeatherTaskTests.swift
//  ALWeatherTaskTests
//
//  Created by Khaled kamal on 3/20/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

@testable import ALWeatherTask
import XCTest

final class ALWeatherTaskTests: XCTestCase {
    var network: WeatherRemoteGetway!

    override func tearDown() {
        network = nil
    }

    func testGetDataWithSuccessScenario() {
        let exp = expectation(description: "Wait for network response")
        network = SuccessNetworkMock()
        network.fetchWeather(api: TestApi.weather, completionHandler: { res in
            switch res {
            case let .sucess(data):
                XCTAssertEqual(data.count, 1)
                exp.fulfill()
            case .failure:
                XCTAssert(false)
            }
        })
        wait(for: [exp], timeout: 0.5)
    }

    func testDataParsingFailure() {
        let exp = expectation(description: "Wait for network response")
        network = FailuerNetworkMock()
        network.fetchWeather(api: TestApi.weather, completionHandler: { res in
            switch res {
            case .sucess:
                XCTAssert(false)
            case let .failure(error):
                XCTAssertEqual(error.describtionError, ResultError.cannotDecodeData.describtionError)
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 0.5)
    }
}

final class SuccessNetworkMock: WeatherRemoteGetway {
    let weatherModel = ALWeatherModel(area:
        ALWArea("", country: "", timezone: 1, lat: 3.3, log: 34.3), weather: ALWweather(WeatherReponseModel(coord: nil, weather: nil, base: .none, main: nil, wind: nil, clouds: nil, dt: nil, sys: nil, timezone: nil, id: nil, name: nil, cod: nil)))
    func fetchWeather(api _: RequstBuilderProtocol, completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void) {
        completionHandler(.sucess([weatherModel]))
    }
}

final class FailuerNetworkMock: WeatherRemoteGetway {
    func fetchWeather(api _: RequstBuilderProtocol, completionHandler: @escaping (ResultStatuts<[ALWeatherModel]>) -> Void) {
        completionHandler(.failure(.cannotDecodeData))
    }
}

enum TestApi: RequstBuilderProtocol {
    var path: String {
        return ""
    }

    case weather
}
