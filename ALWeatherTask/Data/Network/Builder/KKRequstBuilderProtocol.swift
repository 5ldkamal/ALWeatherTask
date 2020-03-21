//
//  KKRequstBuilderProtocol.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/1/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation

public typealias Parmaters = [String: Any]
public typealias Headers = [String: String]

/// url requst use to send requst
public protocol URLRequstProtocol
{
    var urlRequst: URLRequest { get }
}
///Requst Builder
public protocol KKRequstBuilderProtocol: URLRequstProtocol, KKResponseProtocol
{
    /// Base Url
    var baseUrl: String { get }
    /// Path
    var path: String { get }
    /// Paramters
    var paramter: Parmaters? { get }
    /// HttpMethod
    var httpMethod: KKHTTPMethod { get }
    /// Headers
    var headers: Headers { get }
}

extension KKRequstBuilderProtocol
{
    public var urlRequst: URLRequest
    {
        print(URL(string: baseUrl + path)!)
        var request = URLRequest(url: URL(string: baseUrl + path)!)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        return request
    }
}
