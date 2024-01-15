//
//  RequestError.swift
//  Musistic
//
//  Created by Yuri Cunha on 15/01/24.
//

import Foundation

enum RequestError: Error {
    case invalidURL, decode, noResponse, expiredToken, noAuthorized, unknown
    case custom(_ error: [String: Any]?)
}
