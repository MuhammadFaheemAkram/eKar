//
//  Bindable.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

class Bindable<T> {
    
    var value: T {
        didSet {
            updateHandler?(value)
        }
    }
    var updateHandler: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
}
