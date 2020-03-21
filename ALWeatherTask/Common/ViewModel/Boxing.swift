//
//  Boxing.swift
//  Debla
//
//  Created by khaledkamal on 3/25/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation

public class Boxing<T> {
    typealias Listner = ((T) -> Void)
    var listner: Listner?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func binding(_ listner: Listner?) {
        self.listner = listner
    }
}
