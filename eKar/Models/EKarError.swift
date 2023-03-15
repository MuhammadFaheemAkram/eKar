//
//  EKarError.swift
//  eKar
//
//  Created by Faheem on 14/03/2023.
//

import Foundation

struct EKarError: Error {
    
    let message: String
    let code: Int
    
    init(message: String, code: Int = 500) {
        self.message = message
        self.code = code
    }
    
}
