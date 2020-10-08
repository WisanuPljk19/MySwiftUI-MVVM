//
//  DialogView.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 8/10/2563 BE.
//

import SwiftUI

struct DialogView: View {
    @Binding var isDisplayed: Bool
    
    var title: String
    var detail: String
    var onClicked: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 32) {
            Text(title)
                .font(.title)
            
            Text(detail)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: 300)
            
            Button(action: {
                self.isDisplayed = false
            }) {
                Text("Dismiss")
            }
        }
        .padding()
    }
    
    init(isDisplayed: Binding<Bool>, title: String, detail: String, onClicked: (() -> Void)? = nil) {
        self._isDisplayed = isDisplayed
        self.title = title
        self.detail = detail
        self.onClicked = onClicked
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView(isDisplayed: .constant(true), title: "Title", detail: "Detail"){
            print("dismiss")
        }
    }
}
