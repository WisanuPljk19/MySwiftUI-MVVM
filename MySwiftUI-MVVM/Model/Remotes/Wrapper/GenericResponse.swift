//
//  GenericResponse.swift
//  ePM_Network
//
//  Created by Wisanu Paunglumjeak on 4/2/2563 BE.
//  Copyright © 2563 CDG Systems Ltd. All rights reserved.
//

import Foundation

class GenericResponse<T: Codable>: Decodable {
    var results: [T]?
    var result: T?
    var message: String?
    var timestamp: String?
    static func toGenericResponse(with data: Data?) -> GenericResponse<T>? {
        guard let dataGeneric = data else {
            return nil
        }
        do {
            let genericResponse:GenericResponse<T> = try JSONDecoder().decode(self, from: dataGeneric)
            return genericResponse
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    private enum CodingKeys: String, CodingKey {
        case result
        case results
        case message
        case timestamp
    }
    init() {
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decodeIfPresent(T.self, forKey: .result)
        results = try container.decodeIfPresent([T].self, forKey: .results)
        message = try container.decodeIfPresent(String.self, forKey: .message)
        timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp)
    }
}

struct ResponseStatus: Codable {
    var status: String?
}

struct ResponseStatusBool: Codable {
    var status: Bool?
}
