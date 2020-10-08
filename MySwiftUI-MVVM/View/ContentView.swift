//
//  ContentView.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 5/10/2563 BE.
//

import SwiftUI

struct ContentView: View {
    @State var modalIsDisplayed = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.modalIsDisplayed.toggle()
            }) {
                Text("Click me!")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
