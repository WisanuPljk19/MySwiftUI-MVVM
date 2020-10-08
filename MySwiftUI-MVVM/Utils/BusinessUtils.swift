//
//  BusinessUtils.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 6/10/2563 BE.
//

import Foundation

class BusinessUtils {
    enum Gender {
        case male
        case female
        
        static func initial(from genderFlag: String?) -> BusinessUtils.Gender? {
            switch genderFlag {
            case self.male.flag:
                return self.male
            case self.female.flag:
                return self.female
            default:
                return nil
            }
        }
        
        var flag: String {
            switch self {
            case .male:
                return "M"
            case .female:
                return "F"
            }
        }
    }
}
