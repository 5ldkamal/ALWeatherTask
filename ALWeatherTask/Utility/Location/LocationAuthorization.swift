//
//  KKLocationAuthorization.swift
//  LocationMangerBuilder
//
//  Created by khaledkamal on 11/17/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import UIKit

extension Notification.Name {
    static let UpdateLocation = Notification.Name("Notification.Name.UpdateLocation")
}

protocol LocationAuthorizationDelegate: class {
    func locationAuthorizationDenied(for locationAuthorization: LocationAuthorization)
}

protocol LocationAuthorization {
    var delegate: LocationAuthorizationDelegate? { get set }
    func askForAuthorization()
}

final class DefaultLocationAuthorization: NSObject {
    let location: LocationManger
    weak var delegate: LocationAuthorizationDelegate?

    init(location: LocationManger) {
        self.location = location
        super.init()
        self.location.authorizedDelegate = self
    }
}

extension DefaultLocationAuthorization: LocationAuthorization {
    func askForAuthorization() {
        switch location.authorizationStatus {
        case .notDetermined:
            location.requestWhenInUseAuthorization()
        default: break
        }
    }
}

extension DefaultLocationAuthorization: KKLocationMangerAuthorizationDelegate {
    private func notifyForAuthorizatin() {
        NotificationCenter.default.post(name: .UpdateLocation, object: self)
    }

    func locationManager(_: LocationManger, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            notifyForAuthorizatin()

        case .denied, .restricted:
            delegate?.locationAuthorizationDenied(for: self)
        default: break
        }
    }
}
