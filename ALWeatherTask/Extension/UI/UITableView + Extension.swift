//
//  UITableView + Extension.swift
//  kiddo
//
//  Created by Mac on 1/7/20.
//  Copyright © 2020 spark-cloud. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    func dequeue<T: UITableViewCell>(indexPath: IndexPath, type: T.Type) -> T {
        return (dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T)!
    }
}

// extension UITableView: StatusController {
//    public var statusView: StatusView? {
//        return DefaultStatusView()
//    }
//
//    func removeStatus() { // Remove PlaceHolder
//        self.view.backgroundColor = .white
//        self.hideStatus()
//    }
// }
