//
//  KKResponseHandler.swift
//  TrueCallerTask
//
//  Created by Khaled kamal on 1/17/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import UIKit

public typealias DataResponse = (Data?, URLResponse?, Error?)
public protocol HandleResponseProtocol {
    func handleResponse<T>(_ response: DataResponse, completion: ResponseResult<T>) where T: Codable
}

final class ResponseHandler: NSObject {}

extension ResponseHandler: HandleResponseProtocol {
    public func handleResponse<T>(_ response: DataResponse, completion: ResponseResult<T>) where T: Codable {
        guard let repoponse = response.1 as? HTTPURLResponse else {
            if let error = response.2 as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                completion(ResultStatuts<T>.failure(ResultError.noInternt))
            } else {
                completion(ResultStatuts<T>.failure(ResultError.serverError(.error(response.2?.localizedDescription))))
            }
            return
        }

        let status = ResponseStatusCode(repoponse.statusCode, error: response.2?.localizedDescription)
        switch status {
        case .success:

            if let json = response.0 {
                do {
                    let decoder = JSONDecoder()
                    let modules = try decoder.decode(T.self, from: json)
                    completion(ResultStatuts<T>.sucess(modules))
                } catch {
                    completion(ResultStatuts<T>.failure(ResultError.serverError(.error(error.localizedDescription))))
                    print(error.localizedDescription)
                }
            } else {
                completion(ResultStatuts<T>.failure(ResultError.cannotDecodeData))
            }

        case let .serverError(serverError): completion(ResultStatuts<T>.failure(serverError))
        }
    }
}
