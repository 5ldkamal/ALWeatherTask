//
//  KKResponseProtocol.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/1/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation
public protocol KKResponseProtocol { //: KKHandleResponseProtocol
    func requst<T>(model: T.Type, complation: @escaping ResponseResult<T>) where T: Codable
}

extension KKResponseProtocol where Self: URLRequstProtocol {
    func requst<T>(model: T.Type, complation: @escaping ResponseResult<T>) where T: Codable {
        let task = URLSession.shared.dataTask(with: self.urlRequst) { data, urlResponse, error in
            /// Handle Response
            let parsing = KKResponseHandler()
            parsing.handleResponse((data, urlResponse, error), completion: complation)
        }
        task.resume()
    }
}
