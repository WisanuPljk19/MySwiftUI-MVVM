//
//  MemberDetailViewModel.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 7/10/2563 BE.
//

import Foundation
import Combine
import SwiftUI

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
    
    var cancellables = Set<AnyCancellable>()
    
    private let onGetPersonSubject = PassthroughSubject<Void, Never>()
    private let onTryErrorSubject = PassthroughSubject<Void, Never>()
    private let onTryUnauth = PassthroughSubject<Void, Never>()
    
    @Published private(set) var person: Person = Person()
    @Published private(set) var isSuccess: Bool = true
    @State var modalIsDisplayed = false
    
    private let responseGetPersonSubject = PassthroughSubject<GenericResponse<Person>?, Never>()
    private let responseTryErrorSubject = PassthroughSubject<GenericResponse<Bool>?, Never>()
    private let responseTryUnauth = PassthroughSubject<GenericResponse<Bool>?, Never>()
    
    init(index: Int) {
        bindInputs(index: index)
        bindOutputs()
    }
    
    private func bindInputs(index: Int) {
        
        onGetPersonSubject.flatMap { _ in
                Repository.person(index: index)
                    .catch { (error: ApiError) -> Empty<GenericResponse<Person>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseGetPersonSubject)
            .store(in: &cancellables)
        
        onTryErrorSubject.flatMap { _ in
                Repository.tryError()
                    .catch { (error: ApiError) -> Empty<GenericResponse<Bool>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseTryErrorSubject)
            .store(in: &cancellables)
        
        onTryUnauth.flatMap { _ in
                Repository.tryUnauth()
                    .catch { (error: ApiError) -> Empty<GenericResponse<Bool>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseTryUnauth)
            .store(in: &cancellables)
        
    }
    
    
    private func bindOutputs() {
        
        responseGetPersonSubject
            .map { $0?.result ?? Person() }
            .assign(to: \.person, on: self)
            .store(in: &cancellables)
        
        responseTryErrorSubject
            .map { $0?.result ?? true }
            .assign(to: \.isSuccess, on: self)
            .store(in: &cancellables)
        
        responseTryUnauth
            .map { $0?.result ?? true }
            .assign(to: \.isSuccess, on: self)
            .store(in: &cancellables)
        
    }
}
