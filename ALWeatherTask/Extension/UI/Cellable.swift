//
//  Cellable.swift
//  Magales
//
//  Created by khaledkamal on 6/26/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import UIKit

public protocol Cellable {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension Cellable where Self: UIView {
    fileprivate static func instanceFromCollection<T: UICollectionViewCell>(_ collection: UICollectionView, indexPath: IndexPath) -> T {
        return collection.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }

    fileprivate static func instanceFromTable<T: UIView>(_ tableView: UITableView) -> T {
        return tableView.dequeueReusableCell(withIdentifier: identifier) as! T
    }
}

extension UIView: Cellable {
    public static var identifier: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }

    public static var nib: UINib {
        return .init(nibName: identifier, bundle: nil)
    }
}

extension UICollectionViewCell {
    class func instance(_ collection: UICollectionView, indexPath: IndexPath) -> Self {
        return instanceFromCollection(collection, indexPath: indexPath)
    }
}

extension UITableViewCell {
    class func instance(_ tableView: UITableView) -> Self {
        return instanceFromTable(tableView)
    }
}

//
// extension UICollectionView
// {
//
//    static func registerNibForm<T: Cellable>(_ cell : T)
//    {
//        register(cell.nib(), forCellWithReuseIdentifier: cell.identifier)
//    }
// }

// MARK: - Register
