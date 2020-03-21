//
//  KKLocationProvider.swift
//  LocationMangerBuilder
//
//  Created by khaledkamal on 11/17/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import UIKit

enum LocationType {
    case oneShot
    case continous
}

protocol LocationProviderDelegate: class {
    func locationProvider(_ location: CLLocationCoordinate2D)
}

protocol LocationProvider {
    var deleagte: LocationProviderDelegate? { get set }
    func getLocation()
}

final class KKDefaultLocationProvider: NSObject {
    weak var deleagte: LocationProviderDelegate?
    let locationManger: LocationManger
    let locationAuthorization: LocationAuthorization
    let locationType: LocationType

    init(locationManger: LocationManger, locationAuthorization: LocationAuthorization, locationType: LocationType = .oneShot) {
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

extension KKDefaultLocationProvider: LocationProvider
{
    func getLocation() {
        locationAuthorization.askForAuthorization()
        NotifyForAuthorizatin()
        locationManger.startUpdatingLocation()
    }

    private func NotifyForAuthorizatin() {
        NotificationCenter.default.addObserver(forName: .UpdateLocation, object: locationAuthorization, queue: nil) { [weak self] _ in
            self?.locationManger.startUpdatingLocation()
        }
    }
}

extension KKDefaultLocationProvider: KKLocationMangerDelegate
{
    func locationManager(_: LocationManger, didUpdateLocations locations: [CLLocation]) {
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
