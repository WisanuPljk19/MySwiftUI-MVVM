//
//  CircleImage.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 5/10/2563 BE.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("ic_member")
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 0.4,
                   height: UIScreen.main.bounds.width * 0.4,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 1))
            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleImage()
                .previewLayout(.sizeThatFits)
        }
    }
}
