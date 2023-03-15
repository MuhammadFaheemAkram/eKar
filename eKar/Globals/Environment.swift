//
//  Environment.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

enum Environment {
	
	case qa
	case production
	
	static var current: Environment { return .production }

	static var baseUrl: URL? {
		switch current {
		case .qa: return URL(string: "")
		case .production: return URL(string: "https://api.carsxe.com/")
		}
	}
	
}
