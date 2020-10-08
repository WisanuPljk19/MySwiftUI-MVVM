//
//  GenericRequest.swift
//  ePM_Network
//
//  Created by Wisanu Paunglumjeak on 4/2/2563 BE.
//  Copyright © 2563 CDG Systems Ltd. All rights reserved.
//

import Foundation

class GenericRequest<T:Codable>: Encodable{
    var requests: [T]?
    var request: T?
    private enum CodingKeys: String, CodingKey{
        case request
        case requests
    }
    init(){}
    init(_ request: T?){
        self.request = request
    }
    init(requests: [T]?){
        self.requests = requests
    }
    
}
