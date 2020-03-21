//
//  KKResult.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/1/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation

public typealias ResponseResult<T> = (ResultStatuts<T>) -> ()

public enum ResultStatuts<T>
{
    case sucess(T)
    case failure(ResultError)
}
