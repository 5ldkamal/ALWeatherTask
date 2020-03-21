//
//  Router.swift
//  KKNavigator
//
//  Created by Khaled kamal on 1/5/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public protocol Naviagator: class, PresentProtocol, NavigationProtocol {
    associatedtype Destination
    associatedtype Factory
    
    // MARK: - Properities
    
    var navigationViewController: UINavigationController? { get set }
    var currentViewController: UIViewController? { get set }
    
    // MARK: - Method
    
    func prepareForTransition(_ destination: Destination)
    
    func trigger(destaintion: Destination)
    
    func setRoot(_ window: UIWindow)
}

// MARK: - Init

extension Naviagator {
    public func trigger(destaintion: Destination) {
        prepareForTransition(destaintion)
    }
    
    public func setRoot(_ window: UIWindow) {
        window.rootViewController = navigationViewController
    }
}

extension Naviagator {
    public func push(_ presented: Presentable, animated: Bool) {
        navigationViewController?.pushViewController(presented, animated: animated)
        currentViewController = presented
    }
    
    public func pop(animated: Bool) {
        navigationViewController?.popViewController(animated: animated)
    }
    
    public func popToIndex(_ index: Int, animated: Bool) {
        guard
            let viewControllers = navigationViewController?.viewControllers,
            viewControllers.count > index
        else { return }
        let viewController = viewControllers[index]
        navigationViewController?.popToViewController(viewController, animated: animated)
        currentViewController = viewController
    }
    
    public func popToPresented(_ presented: Presentable, animated: Bool) {
        guard
            let viewControllers = navigationViewController?.viewControllers,
            let viewController = viewControllers.first(where: {
                type(of: $0) == type(of: Presentable.self)
            })
        else { return }
        navigationViewController?.popToViewController(viewController, animated: true)
        currentViewController = viewController
    }
    
    public func setRoot(_ presented: Presentable) {
        navigationViewController?.viewControllers = [presented]
    }
}

extension Naviagator
{
    public func present(_ presented: Presentable, animated: Bool, complation: @escaping () -> ()) {
        currentViewController?.present(presented, animated: animated, completion: complation)
    }
    
    public func dismiss(animated: Bool, complation: @escaping () -> ()) {
        let presentingViewController = currentViewController?.presentingViewController
        currentViewController?.dismiss(animated: animated, completion: complation)
        currentViewController = presentingViewController
    }
}

public protocol PresentProtocol {
    func present(_ presented: Presentable, animated: Bool, complation: @escaping () -> ())
    func dismiss(animated: Bool, complation: @escaping () -> ())
}

public protocol NavigationProtocol {
    func push(_ presented: Presentable, animated: Bool)
    
    func pop(animated: Bool)
    
    func popToIndex(_ index: Int, animated: Bool)
    
    func popToPresented(_ presented: Presentable, animated: Bool)
    
    func setRoot(_ presented: Presentable)
}
