//
//  ContentView.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 5/10/2563 BE.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var progress: Double = 0
    @Published var person: Person = Person()
}

struct ContentView: View {
    @EnvironmentObject var model: ViewModel

    var body: some View {
        VStack {
            TextField("", value: self.$model.person.d, formatter: NumberFormatter())
            Slider(value: self.$model.person.d, in: 0...100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
