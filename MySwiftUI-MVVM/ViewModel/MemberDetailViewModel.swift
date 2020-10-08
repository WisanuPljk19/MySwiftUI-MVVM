//
//  MemberDetailViewModel.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 7/10/2563 BE.
//

import Foundation
import Combine

final class MemberDetailViewModel: ObservableObject, UnidirectionalDataFlowType {
    
    typealias InputType = Input
    
    enum Input {
        case onGetPerson
        case tryError
        case tryUnauth
    }
    func apply(_ input: Input) {
        switch input {
        case .onGetPerson: onGetPersonSubject.send()
        case .tryError: onTryErrorSubject.send()
        case .tryUnauth: onTryUnauth.send()
        }
    }
    
    var cancellables: [AnyCancellable] = []
    
    private let onGetPersonSubject = PassthroughSubject<Void, Never>()
    private let onTryErrorSubject = PassthroughSubject<Void, Never>()
    private let onTryUnauth = PassthroughSubject<Void, Never>()
    
    @Published private(set) var person: Person = Person()
    @Published private(set) var isSuccess: Bool = true
    
    private let responseGetPersonSubject = PassthroughSubject<GenericResponse<Person>?, Never>()
    private let responseTryErrorSubject = PassthroughSubject<GenericResponse<Bool>?, Never>()
    private let responseTryUnauth = PassthroughSubject<GenericResponse<Bool>?, Never>()
    
    init(index: Int) {
        bindInputs(index: index)
        bindOutputs()
    }
    
    private func bindInputs(index: Int) {
        
        let getPersonStream = onGetPersonSubject
            .flatMap { _ in
                Repository.person(index: index)
                    .catch { (error: APIError) -> Empty<GenericResponse<Person>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseGetPersonSubject)
        
        let tryErrorStream = onTryErrorSubject
            .flatMap { _ in
                Repository.tryError()
                    .catch { (error: APIError) -> Empty<GenericResponse<Bool>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseTryErrorSubject)
        
        let tryUnauthStream = onTryUnauth
            .flatMap { _ in
                Repository.tryUnauth()
                    .catch { (error: APIError) -> Empty<GenericResponse<Bool>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseTryUnauth)
        
        cancellables += [getPersonStream, tryErrorStream, tryUnauthStream]
    }
    
    private func bindOutputs() {
        
        let personStream = responseGetPersonSubject
            .map { $0?.result ?? Person() }
            .assign(to: \.person, on: self)
        
        let errorStream = responseTryErrorSubject
            .map { $0?.result ?? true }
            .assign(to: \.isSuccess, on: self)
        
        let unauthStream = responseTryUnauth
            .map { $0?.result ?? true }
            .assign(to: \.isSuccess, on: self)
        
        cancellables += [
            personStream,
            errorStream,
            unauthStream
        ]
        
    }
}
