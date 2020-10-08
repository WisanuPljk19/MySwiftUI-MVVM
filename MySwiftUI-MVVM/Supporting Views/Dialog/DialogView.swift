//
//  DialogView.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 8/10/2563 BE.
//

import SwiftUI

struct DialogView: View {
    @Binding var isDisplayed: Bool
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Nice modal, eh?")
                .font(.title)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nec tellus pellentesque urna sollicitudin sagittis. Fusce sem justo, eleifend eget dignissim sed, convallis at velit.")
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
    
    init(isDisplayed: Binding<Bool>) {
        self._isDisplayed = isDisplayed
    }
}

extension View {
    func modal<ModalBody: View>(
            isPresented: Binding<Bool>,
            @ViewBuilder modalBody: () -> ModalBody
    ) -> some View {
        ModalView(
            isPresented: isPresented,
            parent: self,
            content: modalBody
        )
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        DialogView(isDisplayed: .constant(true))
    }
}
