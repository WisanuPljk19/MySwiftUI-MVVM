//
//  Repository.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 6/10/2563 BE.
//

import Foundation
import Combine

class Repository {

    class func person(index: Int) -> AnyPublisher<GenericResponse<Person>?, APIError> {
        return ApiService<Person>.shared.serviceWithoutAccess(.person(index), params: nil)
    }
    
    class func tryError() -> AnyPublisher<GenericResponse<Bool>?, APIError>{
        return ApiService<Bool>.shared.serviceWithoutAccess(.tryError, params: nil)
    }
    
    class func tryUnauth() -> AnyPublisher<GenericResponse<Bool>?, APIError>{
        return ApiService<Bool>.shared.serviceWithoutAccess(.tryUnauth, params: nil)
    }
}
