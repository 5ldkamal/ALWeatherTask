//
//  KAppCoordinator.swift
//  kiddo
//
//  Created by Khaled kamal on 1/7/20.
//  Copyright © 2020 spark-cloud. All rights reserved.
//

import UIKit

enum Coordination {
    case weather
}

public protocol KAppCoordinatorProtocol {
    func start()
}

final class AppCoordinator: KAppCoordinatorProtocol {
    private let coordinate: Coordination
    private let window: UIWindow
    init(coordinate: Coordination, window: UIWindow) {
        self.coordinate = coordinate
        self.window = window
    }

    func start() {
        switch coordinate {
        case .weather:
            let main = MainRouter(window: window)
            main.trigger(destaintion: .main)
        }
    }
}
