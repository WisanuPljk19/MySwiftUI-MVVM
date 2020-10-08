//
//  Repository.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 6/10/2563 BE.
//

import Foundation
import Combine

class Repository {

    class func person(index: Int) -> AnyPublisher<GenericResponse<Person>?, ApiError> {
        return ApiManager<Person>.shared.serviceWithoutAccess(.person(index), params: nil)
    }
    
    class func tryError() -> AnyPublisher<GenericResponse<Bool>?, ApiError>{
        return ApiManager<Bool>.shared.serviceWithoutAccess(.tryError, params: nil)
    }
    
    class func tryUnauth() -> AnyPublisher<GenericResponse<Bool>?, ApiError>{
        return ApiManager<Bool>.shared.serviceWithoutAccess(.tryUnauth, params: nil)
    }
}
