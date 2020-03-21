//
//  UIViewController+Extension.swift
//  kiddo
//
//  Created by Khaled kamal on 12/29/19.
//  Copyright © 2019 spark-cloud. All rights reserved.
//

import UIKit

public enum StoryBoard: String {
    case main = "Main"
}

extension UIStoryboard {
    static func instance(_ name: StoryBoard) -> Self {
        return (UIStoryboard(name: name.rawValue, bundle: nil) as? Self)!
    }
}

// MARK: - Instate

extension UIViewController {
    private static var nameOf: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    private class func instate<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T {
        return (storyboard.instantiateViewController(withIdentifier: identifier) as? T)!
    }

    private class func instate(_ storyboard: StoryBoard) -> Self {
        let stb = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return instate(stb, identifier: nameOf)
    }

    public class func instanceVc(_ storyboard: StoryBoard = .main) -> Self {
        return instate(storyboard)
    }
}

extension UIViewController: StatefulView {
    private func hideSubViews() {
        for view in view.subviews {
            view.isHidden = true
        }
    }

    private func showSubViews() {
        for view in view.subviews {
            view.isHidden = false
        }
    }

    public func render(state: BaseViewState) {
        switch state {
        case let .isLoading(status):
            if status {
                hideSubViews()
            }
        case .loaded: // Loaded
            showSubViews()

        case let .error(error, status):
            if status {
                hideSubViews()
            }
            AlertBuilder.errorAlert(message: error.describtionError).present(from: self)
        default: break
        }
    }
}
