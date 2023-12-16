//
//  APIImage.swift
//  Musistic
//
//  Created by Yuri Cunha on 16/12/23.
//

import Foundation

struct APIImage: Codable,Hashable {
    let url: String
    let height, width: Int
}
