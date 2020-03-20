//
//  KKLocationManger.swift
//  LocationMangerBuilder
//
//  Created by khaledkamal on 11/17/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import UIKit

protocol KKLocationManger: class {
    var authorizationStatus: CLAuthorizationStatus { get }
    
    var delegate: KKLocationMangerDelegate? { get set }
    var authorizedDelegate: KKLocationMangerAuthorizationDelegate? { get set }
    
    func requestWhenInUseAuthorization()
    func stopUpdatingLocation()
    func startUpdatingLocation()
}

protocol KKLocationMangerDelegate: class {
    func locationManager(_ manager: KKLocationManger, didUpdateLocations locations: [CLLocation])
}

protocol KKLocationMangerAuthorizationDelegate: class {
    func locationManager(_ manager: KKLocationManger, didChangeAuthorization status: CLAuthorizationStatus)
}

class KKLocationMangerProxy: NSObject {
    weak var delegate: KKLocationMangerDelegate?
    weak var authorizedDelegate: KKLocationMangerAuthorizationDelegate?
    
    let locationManger: CLLocationManager
    init(locationManger: CLLocationManager) {
        self.locationManger = locationManger
        super.init()
        self.locationManger.delegate = self
    }
}

extension KKLocationMangerProxy: KKLocationManger {
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

extension KKLocationMangerProxy: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationManager(self, didUpdateLocations: locations)
    }
}

extension KKLocationMangerProxy
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizedDelegate?.locationManager(self, didChangeAuthorization: status)
    }
}
