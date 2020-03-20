//
//  KKLocationAuthorization.swift
//  LocationMangerBuilder
//
//  Created by khaledkamal on 11/17/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import CoreLocation
import UIKit

extension Notification.Name
{
    static let UpdateLocation = Notification.Name("Notification.Name.UpdateLocation")
}

protocol KKLocationAuthorizationDelegate: class
{
    func locationAuthorizationDenied(for locationAuthorization: KKLocationAuthorization)
}

protocol KKLocationAuthorization
{
    var delegate: KKLocationAuthorizationDelegate? { get set }
    func askForAuthorization()
}

final class KKDefaultLocationAuthorization: NSObject
{
    let location: KKLocationManger
    weak var delegate: KKLocationAuthorizationDelegate?

    init(location: KKLocationManger)
    {
        self.location = location
        super.init()
//        self.location.authorizedDelegate = self
    }
}

extension KKDefaultLocationAuthorization: KKLocationAuthorization
{
    func askForAuthorization()
    {
        switch location.authorizationStatus
        {
        case .notDetermined:
            location.requestWhenInUseAuthorization()
        default: break
        }
    }
}

extension KKDefaultLocationAuthorization: KKLocationMangerAuthorizationDelegate
{
    private func NotifyForAuthorizatin()
    {
        NotificationCenter.default.post(name: .UpdateLocation, object: self)
    }

    func locationManager(_ manager: KKLocationManger, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status
        {
        case .authorizedAlways, .authorizedWhenInUse:
            self.NotifyForAuthorizatin()

        case .denied, .restricted:
            delegate?.locationAuthorizationDenied(for: self)
        default: break
        }
    }
}
