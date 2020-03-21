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

final class ALWLocationManger: NSObject {
    weak var delegate: BLocationOutRepoDelegate?

    private let locationManger: CLLocationManager
    private let locationProxy: LocationMangerProxy
    private let auth: DefaultLocationAuthorization
    private let locationProvider: KKDefaultLocationProvider

    init(type _: LocationType = .oneShot) {
        // location
        locationManger = CLLocationManager()
        locationProxy = LocationMangerProxy(locationManger: locationManger)
        auth = DefaultLocationAuthorization(location: locationProxy)
        locationProvider = KKDefaultLocationProvider(locationManger: locationProxy, locationAuthorization: auth)

        super.init()
        auth.delegate = self
        locationProvider.deleagte = self
    }
}

extension ALWLocationManger: BLocationRepoProtocol {
    func getLocation() {
        locationProvider.getLocation()
    }
}

// MARK: - HandleLocaiton

extension ALWLocationManger: LocationProviderDelegate {
    func locationProvider(_ location: CLLocationCoordinate2D) {
        delegate?.location(location)
    }
}

extension ALWLocationManger: LocationAuthorizationDelegate {
    func locationAuthorizationDenied(for _: LocationAuthorization) {
        delegate?.locationFailed()
    }
}
