//
//  KKLocationProvider.swift
//  LocationMangerBuilder
//
//  Created by khaledkamal on 11/17/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import UIKit

enum KKLocationType {
    case oneShot
    case continous
}

protocol KKLocationProviderDelegate: class {
    func locationProvider(_ location: CLLocationCoordinate2D)
}

protocol KKLocationProvider {
    var deleagte: KKLocationProviderDelegate? { get set }
    func getLocation()
}

class KKDefaultLocationProvider: NSObject {
    weak var deleagte: KKLocationProviderDelegate?
    let locationManger: KKLocationManger
    let locationAuthorization: KKLocationAuthorization
    let locationType: KKLocationType

    init(locationManger: KKLocationManger, locationAuthorization: KKLocationAuthorization, locationType: KKLocationType = .oneShot) {
        self.locationManger = locationManger
        self.locationAuthorization = locationAuthorization
        self.locationType = locationType
        super.init()

        locationManger.delegate = self
    }

    deinit {
        locationManger.stopUpdatingLocation()
    }
}

extension KKDefaultLocationProvider: KKLocationProvider
{
    func getLocation() {
        locationAuthorization.askForAuthorization()
        NotifyForAuthorizatin()
        self.locationManger.startUpdatingLocation()
    }

    private func NotifyForAuthorizatin() {
        NotificationCenter.default.addObserver(forName: .UpdateLocation, object: locationAuthorization, queue: nil) { [weak self] _ in
            self?.locationManger.startUpdatingLocation()
        }
    }
}

extension KKDefaultLocationProvider: KKLocationMangerDelegate
{
    func locationManager(_ manager: KKLocationManger, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let location2D = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)

        if locationType == .oneShot {
            locationManger.stopUpdatingLocation()
            locationManger.delegate = nil
        }
        deleagte?.locationProvider(location2D)
    }
}
