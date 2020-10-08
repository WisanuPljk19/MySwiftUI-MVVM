//
//  ApiConfig.swift
//  ePM_Network
//
//  Created by Wisanu Paunglumjeak on 4/2/2563 BE.
//  Copyright © 2563 CDG Systems Ltd. All rights reserved.
//

import Foundation
import Alamofire

enum Root: String {
    case mocky
	case serviceHost
}

enum ContentType: String{
	case none = "**"
	case json = "application/json;charset=UTF-8"
	case multipart = "multipart/form-data"
	case octetStream = "application/octet-stream;charset=UTF-8"
	case form = "application/x-www-form-urlencoded;charset=UTF-8"
}

enum HttpStatusCode: Int {
	case SUCCESS = 200
	case NO_CONTENT = 204
	case BAD_REQUEST = 400
	case UNAUTHORIZED = 401
	case FORBIDDEN = 403
	case SERVER_ERROR = 500
}

enum Service {
	case renewAccessToken
	case auth
	case familyList
    case person(Int)
    case tryError
    case tryUnauth
}

extension Service {
	var serviceConfig: ServiceConfig {
		switch self {
		case .auth:
			return ServiceConfig(root: .serviceHost,
								 service: "auth",
								 method: .post,
								 contentType: .json)
		case .renewAccessToken:
			return ServiceConfig(root: .mocky,
								 service: "2256f374-6ee2-40a7-a66a-dd2db38d8420",
								 method: .post,
								 contentType: .json)
        case .familyList:
            return ServiceConfig(root: .serviceHost,
                                 service: "families/.json",
                                 method: .get,
                                 contentType: .none)
        case .person(let index):
            return ServiceConfig(root: .serviceHost,
                                 service: "persons/\(index).json",
                                 method: .get,
                                 contentType: .none)
        case .tryError:
            return ServiceConfig(root: .mocky,
                                 service: "fdb03501-3bc3-41b0-acc2-a5878a2560ea",
                                 method: .post,
                                 contentType: .json)
        case .tryUnauth:
            return ServiceConfig(root: .mocky,
                                 service: "ae7c5b64-00cc-48dc-93fa-ba73235a74e4",
                                 method: .get,
                                 contentType: .none)
        }
		
	}
	
	class ServiceConfig {
		let serviceUrl: String
		let servicePath: String
		let method: HTTPMethod
		let contentType: ContentType
		
		init(root: Root, service: String, method: HTTPMethod, contentType: ContentType) {
			var apiContextRoot = ""
			switch root {
			case .serviceHost:
				apiContextRoot = (Bundle.main.object(forInfoDictionaryKey: "SERVICE_HOST") as! String)
            case .mocky:
                apiContextRoot = "https://run.mocky.io/v3/"
			}
			self.serviceUrl = "\(apiContextRoot)\(service)"
			self.servicePath = service
			self.method = method
			self.contentType = contentType
		}
	}
}

