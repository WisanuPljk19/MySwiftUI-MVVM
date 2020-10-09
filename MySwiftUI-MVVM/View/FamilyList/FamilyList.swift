//
//  FamilyList.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 9/10/2563 BE.
//

import SwiftUI

struct FamilyList: View {
    
    @ObservedObject var viewModel: FamilyListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.families.enumerated().map{ $0 }, id: \.element.id){ index, person in
                    NavigationLink(destination: MemberDetailView(viewModel: .init(index: index))){
                        FamilyRow(person: person)
                    }
                }
                .navigationBarTitle(Text("ครอบครัวของฉัน"))
                Button("Add") {
                    print("Add Me")
                }
            }
        }
        .onAppear(perform: {
            viewModel.apply(.onGetFamilyList)
        })
    }
}

struct FamilyList_Previews: PreviewProvider {
    static var previews: some View {
        FamilyList(viewModel: .init())
    }
}
