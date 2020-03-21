//
//  BaseCoordinator.swift
//  kiddo
//
//  Created by Khaled kamal on 1/7/20.
//  Copyright © 2020 spark-cloud. All rights reserved.
//

import UIKit

open class KKBaseCoordinator<D, F>:Naviagator  {
    
    //MARK:- Type Aias
    public typealias Destination = D
    public typealias Factory     = F
    
    //MARK: - Properities
    public  var navigationViewController: UINavigationController?
    
    public var currentViewController    : UIViewController?
    
    
    //MARK: - Method
    public  init(window: UIWindow?) {
    }
    public  init(rootViewController: Presentable?) {
    }
    
    public func factory()->Factory?
    {
        assert(false, "Plz implemmnet this methos")
        return nil
        
    }
    
    public func prepareForTransition(_ destination: D) {
    }
    
    
}
