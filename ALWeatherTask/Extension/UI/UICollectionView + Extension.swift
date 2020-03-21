//
//  UICollectionView + Extension.swift
//  kiddo
//
//  Created by Mac on 1/7/20.
//  Copyright © 2020 spark-cloud. All rights reserved.
//

import Foundation
import UIKit
extension UICollectionView {
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath, type: Cell.Type) -> Cell {
        return (dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as? Cell)!
    }
}
