//
//  Constants.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 5/10/2563 BE.
//

import Foundation
import Necromancer
import SwiftUI

typealias Utils = Necromancer

enum AppFonts {
    static let KanitLight15 = Font.custom("Kanit-Light", size: 15)
    static let KanitLight13 = Font.custom("Kanit-Light", size: 13)
    static let KanitMedium15 = Font.custom("Kanit-Medium", size: 15)
    static let KanitRegular15 = Font.custom("Kanit-Regular", size: 15)
    static let KanitMedium24 = Font.custom("Kanit-Medium", size: 24)
    static let KanitLight8 = Font.custom("Kanit-Light", size: 8)
}


enum Message {
    static let serviceError = "เกิดข้อผิดพลาด"
    static let serviceDataNotFound = "ไม่พบข้อมูล"
    static let connectNetworkForUsing = "กรุณาเชื่อมต่อเครือข่ายเพื่อใช้งาน"
    static let sessionExpire = "คุณไม่ได้ใช้งานนานเกินไป กรุณาเข้าสู่ระบบใหม่"
    static let saveSuccess = "บันทึกข้อมูลสำเร็จแล้ว"
    static let saveFailed = "บันทึกข้อมูลไม่สำเร็จ"
}

enum PreferenceKeys{
    static let refreshToken = "refresh_token"
    static let accessToken = "access_token"
}

