//
//  KKRequstBuilderProtocol+Extension.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/2/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation

extension KKRequstBuilderProtocol
{
    var baseUrl: String
    {
        return "http://api.openweathermap.org/data/2.5/"
    }

    var paramter: Parmaters?
    {
        return nil
    }

    var httpMethod: KKHTTPMethod
    {
        return .get
    }

    var headers: Headers
    {
        return [:]
    }
}
