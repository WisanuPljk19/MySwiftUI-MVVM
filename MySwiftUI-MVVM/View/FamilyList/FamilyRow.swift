//
//  FamilyRow.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 9/10/2563 BE.
//

import SwiftUI

struct FamilyRow: View {
    
    var person: Person
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(person.fullName())
                    .font(AppFonts.KanitMedium24)
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5490196078, blue: 0.1254901961, alpha: 1)))
                Text(Utils.DateTimes.toString(from: person.birthDate, with: .fullShortDate) ?? "")
                    .font(AppFonts.KanitLight15)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
            }
            Spacer()
            Text(person.sex?.flag ?? "")
                .font(AppFonts.KanitMedium24)
                .foregroundColor(person.sex?.color)
        }
    }
}

struct FamilyRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FamilyRow(person: Person.init(firstName: "Tony",
                                          lastName: "Jar",
                                          sex: .male,
                                          birthDate: Date()))
                .previewLayout(.fixed(width: 300, height: 70))
            FamilyRow(person: Person.init(firstName: "Emmy",
                                          lastName: "Jar",
                                          sex: .female,
                                          birthDate: Date()))
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
