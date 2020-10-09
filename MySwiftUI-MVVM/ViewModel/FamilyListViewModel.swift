//
//  Family.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 9/10/2563 BE.
//

import Foundation
import Combine

final class FamilyListViewModel: ObservableObject, UnidirectionalDataFlowType {
    typealias InputType = Input
    
    enum Input {
        case onGetFamilyList
    }
    func apply(_ input: Input) {
        switch input {
        case .onGetFamilyList: onGetFamilyListSubject.send()
        }
    }
    
    var cancellables = Set<AnyCancellable>()
    
    private let onGetFamilyListSubject = PassthroughSubject<Void, Never>()
    
    @Published private(set) var families: [Person] = []
    
    private let responseGetFamilyListSubject = PassthroughSubject<GenericResponse<Person>?, Never>()
    
    init() {
        bindInputs()
        bindOutputs()
    }
    
    private func bindInputs() {
        onGetFamilyListSubject.flatMap { _ in
                Repository.families()
                    .catch { (error: ApiError) -> Empty<GenericResponse<Person>?, Never> in
                        print(error.errorResponse.message ?? "")
                        return .init()
                    }
            }.share()
            .subscribe(responseGetFamilyListSubject)
            .store(in: &cancellables)
    }
    
    private func bindOutputs() {
        responseGetFamilyListSubject
            .map { $0?.results ?? [] }
            .assign(to: \.families, on: self)
            .store(in: &cancellables)
    }
}
