//
//  KMainRouter.swift
//  kiddo
//
//  Created by Khaled kamal on 1/7/20.
//  Copyright © 2020 spark-cloud. All rights reserved.
//

import UIKit
enum MainDestinationRouter {
    case main
    case Details(ALWeatherModel)
}

final class MainRouter: BaseCoordinator<MainDestinationRouter, MainFactoryProtocol> {
    private let window: UIWindow?

    override init(window: UIWindow?) {
        self.window = window
        super.init(window: window)
        navigationViewController = UIStoryboard.instance(.Main).instantiateViewController(identifier: "MainNav")
        self.window?.rootViewController = navigationViewController
    }

    override func factory() -> MainFactoryProtocol? {
        return MainFactory(coordinator: self)
    }

    public override func prepareForTransition(_ destination: MainDestinationRouter) {
        switch destination {
        case .main: setRoot(factory()!.main())
        case let .Details(model): push(factory()!.details(model), animated: true)
        }
    }
}
