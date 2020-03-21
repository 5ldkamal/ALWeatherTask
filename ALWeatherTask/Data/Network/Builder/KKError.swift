//
//  KKError.swift
//  KKNetwokLayer
//
//  Created by khaledkamal on 9/1/19.
//  Copyright © 2019 khaledkamal. All rights reserved.
//

import Foundation

public enum ResponseStatusCode {
    init(_ statusCode: Int, error: String?) {
        switch statusCode {
        case 200:

            self = ResponseStatusCode.success

        default: self = ResponseStatusCode.serverError(ResultError(statusCode, error: error))
        }
    }

    case success
    case serverError(ResultError)
}

public enum ResultError {
    init(_ statusCode: Int, error: String?) {
        switch statusCode {
        case NSURLErrorCannotDecodeRawData, NSURLErrorCannotDecodeContentData, NSURLErrorCannotParseResponse: self = .cannotDecodeData
        case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet: self = .noInternt

        default: self = .serverError(ServerError(statusCode, error: error))
        }
    }

    case cannotDecodeData

    case noInternt

    case serverError(ServerError)

    case dataBase(String)
    
    case location(String)

    public var describtionError: String {
        switch self {
        case .serverError(let error):
            return error.error
        case .noInternt:
            return NSLocalizedString("No Internet connection.Make sure that Wi-Fi or mobile data is turned on that try again", comment: "")
        case .dataBase(let error):
            return error
            
        case .location(let error):
            return error
        default:
            return ""
        }
    }
}

public enum ServerError {
    init(_ errorCode: Int, error: String?) {
        switch errorCode {
        case NSURLErrorBadURL, NSURLErrorUnsupportedURL, NSURLErrorCannotFindHost: self = .badUrl
        case 401: self = .tokenExpire
        case 403: self = .forbiden
        case 412: self = .validateInputs
        case 500: self = .internalServerError

        default: self = .error(error)
        }
    }

    case error(String?) // Error.Description
    case badUrl // 400
    case tokenExpire // 401
    case validateInputs // 412
    case forbiden // 403
    case internalServerError // 500
    case badServerResponse

    public var error: String {
        switch self {
        case .error(let errorDescription):
            return errorDescription ?? ""

        case .badUrl:
            return "Bad url , you cannot access method"

        default:
            return "Server Error"
        }
    }
}

// public enum KKError : Error {
//
//    var localizedDescription: String
//    {
//        switch self {
//        case .cannotDecode:
//            return"Cannot decode date"
//        case .noInternet:
//            return  NSLocalizedString("noInternet", comment: "")
//        case .error(let error):
//            return  error
//        case .tokenExpire:
//            return  NSLocalizedString("tokenExpire", comment: "")
//        case .validateInputs:
//            return  NSLocalizedString("validateInputs", comment: "")
//        case .badUrl:
//            return  NSLocalizedString("badUrl", comment: "")
//        case .forbiden:
//            return  NSLocalizedString("forbiden", comment: "")
//        case .internalServerError:
//            return  NSLocalizedString("internalServerError", comment: "")
//        }
//    }
//
//    case cannotDecode //Handle ComminDate
//    case noInternet //---
//    case error(String) // Error.Description
//    case tokenExpire // 401
//    case validateInputs //412
//    case badUrl // 400
//    case forbiden //403
//    case internalServerError //500
//
// }
