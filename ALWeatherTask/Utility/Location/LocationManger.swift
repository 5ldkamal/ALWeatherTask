//
//  KKLocationManger.swift
//  LocationMangerBuilder
//
//  Created by khaledkamal on 11/17/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import UIKit

protocol LocationManger: class {
    var authorizationStatus: CLAuthorizationStatus { get }
    var delegate: KKLocationMangerDelegate? { get set }
    var authorizedDelegate: KKLocationMangerAuthorizationDelegate? { get set }
    /// Methods
    func requestWhenInUseAuthorization()
    func stopUpdatingLocation()
    func startUpdatingLocation()
}

protocol KKLocationMangerDelegate: class {
    func locationManager(_ manager: LocationManger, didUpdateLocations locations: [CLLocation])
}

protocol KKLocationMangerAuthorizationDelegate: class {
    func locationManager(_ manager: LocationManger, didChangeAuthorization status: CLAuthorizationStatus)
}

final class LocationMangerProxy: NSObject {
    weak var delegate: KKLocationMangerDelegate?
    weak var authorizedDelegate: KKLocationMangerAuthorizationDelegate?

    let locationManger: CLLocationManager
    init(locationManger: CLLocationManager) {
        self.locationManger = locationManger
        super.init()
        self.locationManger.delegate = self
    }
}

extension LocationMangerProxy: LocationManger {
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    func requestWhenInUseAuthorization() {
        locationManger.requestWhenInUseAuthorization()
    }

    func stopUpdatingLocation() {
        locationManger.stopUpdatingLocation()
    }

    func startUpdatingLocation() {
        locationManger.startUpdatingLocation()
    }
}

extension LocationMangerProxy: CLLocationManagerDelegate
{
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationManager(self, didUpdateLocations: locations)
    }
}

extension LocationMangerProxy
{
    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizedDelegate?.locationManager(self, didChangeAuthorization: status)
    }
}
