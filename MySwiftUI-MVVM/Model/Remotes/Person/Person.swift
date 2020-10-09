//
//  Person.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 6/10/2563 BE.
//

import Foundation
import Necromancer

class Person: Codable {
    var birthDate: Date?
    var firstName: String?
    var lastName: String?
    var id: Int?
    var note: String?
    var sex: BusinessUtils.Gender?
    
    func fullName() -> String{
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    init() {
        
    }
    
    init(firstName: String,
             lastName: String,
             sex: BusinessUtils.Gender,
             birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.sex = sex
        self.birthDate = birthDate
    }
    
    private enum CodingKeys: String, CodingKey {
        case birthDate
        case firstName
        case lastName
        case id
        case note
        case sex
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let birthDateStr = try container.decodeIfPresent(String.self, forKey: .birthDate) {
            self.birthDate = Utils.DateTimes.toDate(from: birthDateStr, with: .timestamp, locale: LocaleDateTime.en)
        }
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.sex = BusinessUtils.Gender.initial(from: try container.decodeIfPresent(String.self, forKey: .sex))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(Utils.DateTimes.toString(from: self.birthDate, with: .timestamp, locale: LocaleDateTime.en), forKey: .birthDate)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(note, forKey: .note)
        try container.encodeIfPresent(sex?.flag, forKey: .sex)
    }

}
