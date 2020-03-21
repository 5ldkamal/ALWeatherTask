//
//  KKResponseProtocol.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/1/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation
public protocol ResponseProtocol { //: KKHandleResponseProtocol
    func requst<T>(model: T.Type, complation: @escaping ResponseResult<T>) where T: Codable
}

extension ResponseProtocol where Self: URLRequstProtocol {
    func requst<T>(model _: T.Type, complation: @escaping ResponseResult<T>) where T: Codable {
        let task = URLSession.shared.dataTask(with: urlRequst) { data, urlResponse, error in
            /// Handle Response
            let parsing = ResponseHandler()
            parsing.handleResponse((data, urlResponse, error), completion: complation)
        }
        task.resume()
    }
}
