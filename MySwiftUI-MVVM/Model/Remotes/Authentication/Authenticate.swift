//
//  Authentication.swift
//  MySwiftUI-MVVM
//
//  Created by Wisanu Paunglumjeak on 8/10/2563 BE.
//

import Foundation

class Authenticate: Codable {
    var personCode: String?
    var password: String?
    var deviceId: String?
    var refreshToken: String?
    var accessToken: String?
    var deviceType: String?
    var messageToken: String?
}
