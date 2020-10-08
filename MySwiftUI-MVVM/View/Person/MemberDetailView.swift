//
//  MemberDetailView.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 5/10/2563 BE.
//

import SwiftUI

struct MemberDetailView: View {

    @ObservedObject var viewModel: MemberDetailViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                CircleImage()
                    .padding(8)
                Text(viewModel.person.fullName())
                    .padding(.top, 8)
                    .font(AppFonts.KanitMedium24)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5490196078, blue: 0.1254901961, alpha: 1)))
                Text(Utils.DateTimes.toString(from: viewModel.person.birthDate, with: .fullShortDate) ?? "")
                    .padding(0)
                    .font(AppFonts.KanitLight13)
                    .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)))
                HStack{
                    SocialButton(image: Image(uiImage: #imageLiteral(resourceName: "facebook")), title: "facebook") {
                        self.viewModel.modalIsDisplayed.toggle()
                    }
                    SocialButton(image: Image(uiImage: #imageLiteral(resourceName: "Instagram")), title: "instagram") {
                        print("instagram")
                    }
                    SocialButton(image: Image(uiImage: #imageLiteral(resourceName: "twitter")), title: "twitter") {
                        print("twitter")
                    }
                }.padding()
                HStack {
                    Text("Note")
                        .font(AppFonts.KanitMedium15)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5490196078, blue: 0.1254901961, alpha: 1)))
                    Spacer()
                }
                HStack {
                    Text(viewModel.person.note ?? "")
                        .font(AppFonts.KanitLight13)
                        .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.231372549, blue: 0.231372549, alpha: 1)))
                    Spacer()
                }
                Spacer()
            }
            .padding(32)
        }
        .onAppear(perform: {
            self.viewModel.apply(.onGetPerson)
        })
//        .modal(isPresented: viewModel.$modalIsDisplayed) {
//            DialogView(isDisplayed: viewModel.$modalIsDisplayed)
//        }
    }
}

struct MemberDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MemberDetailView(viewModel: .init(index: 0))
            .previewDevice("iPhone SE (2nd generation)")
    }
}
