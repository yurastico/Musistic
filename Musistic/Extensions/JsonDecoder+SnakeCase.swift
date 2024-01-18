//
//  JsonDecoder+SnakeCase.swift
//  Musistic
//
//  Created by Yuri Cunha on 18/01/24.
//

import Foundation

extension JSONDecoder {
    convenience init(stragegy: KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = stragegy
        
    }
}
