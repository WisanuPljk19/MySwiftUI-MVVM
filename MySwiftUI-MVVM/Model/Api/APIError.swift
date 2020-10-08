//
//  APIServiceError.swift
//  SwiftUI-MVVM
//
//  Created by Yusuke Kita on 6/6/19.
//  Copyright © 2019 Yusuke Kita. All rights reserved.
//

import Foundation
import Alamofire

enum APIError: Error {
    init(error: AFError) {
        self = .network
    }
    
    case network
    case custom(Int?, String?)
    case none
    
    var errorResponse: ErrorResponse {
        switch self {
        case .network:
            return ErrorResponse(message: "Newwork Error")
        case .custom(let statusCode, let message):
            return ErrorResponse(statusCode: statusCode, message: message)
        default:
            return ErrorResponse()
        }
    }
}
