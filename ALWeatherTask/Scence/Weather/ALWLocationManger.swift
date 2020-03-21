//
//  ALWLocationManger.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/20/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreLocation
import UIKit

// MARK: - Location

public protocol BLocationRepoProtocol: class {
    var delegate: BLocationOutRepoDelegate? { get set }
    func getLocation()
}

public protocol BLocationOutRepoDelegate: class {
    func location(_ location: CLLocationCoordinate2D)
    func locationFailed()
}

class ALWLocationManger: NSObject {
    weak var delegate: BLocationOutRepoDelegate?

    private let locationManger: CLLocationManager
    private let locationProxy: KKLocationMangerProxy
    private let auth: KKDefaultLocationAuthorization
    private let locationProvider: KKDefaultLocationProvider

    init(type: KKLocationType = .oneShot) {
        // location
        locationManger = CLLocationManager()
        locationProxy = KKLocationMangerProxy(locationManger: locationManger)
        auth = KKDefaultLocationAuthorization(location: locationProxy)
        locationProvider = KKDefaultLocationProvider(locationManger: locationProxy, locationAuthorization: auth)

        super.init()
        auth.delegate = self
        locationProvider.deleagte = self
    }
}

extension ALWLocationManger: BLocationRepoProtocol
{
    func getLocation() {
        locationProvider.getLocation()
    }
}

// MARK: - HandleLocaiton

extension ALWLocationManger: KKLocationProviderDelegate
{
    func locationProvider(_ location: CLLocationCoordinate2D) {
        delegate?.location(location)
    }
}

extension ALWLocationManger: KKLocationAuthorizationDelegate
{
    func locationAuthorizationDenied(for locationAuthorization: KKLocationAuthorization) {
        delegate?.locationFailed()
    }
}
