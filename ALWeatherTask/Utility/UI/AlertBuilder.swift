//
//  AlertBuilder.swift
//  Etgawez
//
//  Created by Fady on 8/1/17.
//  Copyright © 2017 Fady Ackad. All rights reserved.
//

import UIKit

public final class AlertBuilder {
    private var alertController: UIAlertController!

    private init(_ style: UIAlertController.Style) {
        alertController = UIAlertController(title: nil, message: nil, preferredStyle: style)
    }

    static func errorAlert(message: String) -> AlertBuilder {
        return AlertBuilder(.alert).title("Weather").message(message)
    }

    static func successAlert(message: String) -> AlertBuilder {
        return AlertBuilder(.alert).title("Weather").message(message)
    }

    static func warningAlert(message: String) -> AlertBuilder {
        return AlertBuilder(.alert).title("Weather").message(message)
    }

    @discardableResult
    func title(_ title: String) -> Self {
        alertController.title = title
        return self
    }

    @discardableResult
    func message(_ message: String) -> Self {
        alertController.message = "\n" + message
        return self
    }

    @discardableResult
    func addAction(_ action: UIAlertAction) -> Self {
        alertController.addAction(action)
        return self
    }

    @discardableResult
    func addDefaultAction(_ handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: handler))
        return self
    }

    @discardableResult
    func addCancelAction(_ handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: handler))
        return self
    }

    @discardableResult
    func addRetryAction(_ handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        alertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: handler))
        return self
    }

    func present(addingDefaultAction: Bool = true, from view: UIViewController?, completion: (() -> Void)? = nil) {
        guard let view = view else {
            return
        }
        if alertController.actions.isEmpty, addingDefaultAction {
            addDefaultAction()
        }
        view.present(alertController, animated: true, completion: completion)
    }

    func prsentT(addingDefaultAction: Bool = false, from view: UIViewController?, completion: (() -> Void)? = nil) {
        guard let view = view else {
            return
        }
        present(addingDefaultAction: addingDefaultAction, from: view, completion: completion)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.alertController.dismiss(animated: true, completion: nil)
        }
    }
}
