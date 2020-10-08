//
//  SocialButton.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 6/10/2563 BE.
//

import SwiftUI

struct SocialButton: View {
    
    let image: Image
    let title: String
    let onClicked: (() -> Void)?
    
    var body: some View {
        Button(action: {onClicked?()}, label: {
            VStack {
                image
                    .resizable()
                    .frame(width: 32,
                           height: 32,
                           alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .scaledToFit()
                Text(title)
                    .font(AppFonts.KanitLight8)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5490196078, blue: 0.1254901961, alpha: 1)))
            }
            .padding()
            .frame(width: 90, height: 90, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(45)
            .overlay(
                    RoundedRectangle(cornerRadius: 45)
                        .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), lineWidth: 1)
                )
        })
    }
}

struct SocialButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialButton(image: Image("facebook"), title: "facebook"){
            
        }
    }
}
