//
//  Presentable.swift
//  KKNavigator
//
//  Created by Khaled kamal on 1/5/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public protocol Presentable where Self: UIViewController {
    var presented: UIViewController { get }
}

extension Presentable
{
    public var presented: UIViewController { return self }
}

///
extension UIViewController: Presentable
{
    public var presented: UIViewController { return self }
}
