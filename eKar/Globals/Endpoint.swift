//
//  Endpoint.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

enum Endpoint {
	
    static var vehicleSpecs: URL? {
        URL(string: "specs", relativeTo: Environment.baseUrl)
    }
    
    static var vehicleImages: URL? {
        URL(string: "images", relativeTo: Environment.baseUrl)
    }
}
