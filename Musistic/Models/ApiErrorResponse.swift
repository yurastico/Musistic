//
//  ApiErrorResponse.swift
//  Musistic
//
//  Created by Yuri Cunha on 24/02/24.
//

import Foundation

struct ApiErrorResponse: Codable {
    let error: String
    let errorDescription: String
}
