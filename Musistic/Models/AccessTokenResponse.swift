//
//  AccessTokenResponse.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/01/24.
//

import Foundation


struct AccessTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let expiresIn: Int
    let refreshToken: String?
}

