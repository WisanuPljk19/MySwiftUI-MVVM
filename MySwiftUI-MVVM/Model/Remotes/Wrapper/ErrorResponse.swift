//
//  ErrorResponse.swift
//  ePM_Network
//
//  Created by Wisanu Paunglumjeak on 4/2/2563 BE.
//  Copyright © 2563 CDG Systems Ltd. All rights reserved.
//

import Foundation

class ErrorResponse: Codable {
    var statusCode: Int?
    var message: String?
    var timestamp: String?
    
    private enum CodingKeys: String, CodingKey {
        case message
        case timestamp
        
    }
    
    init() {
    }
    
    init(statusCode: Int? = nil, message: String?, timestamp: String? = nil) {
        self.statusCode = statusCode
        self.message = message
        self.timestamp = timestamp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp)
    }
}
