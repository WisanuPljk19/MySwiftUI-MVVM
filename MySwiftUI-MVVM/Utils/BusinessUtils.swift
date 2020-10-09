//
//  BusinessUtils.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 6/10/2563 BE.
//

import Foundation
import SwiftUI

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
        
        var color: Color {
            switch self {
            case .male:
                return Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
            case .female:
                return Color(#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1))
            }
        }
    }
}
