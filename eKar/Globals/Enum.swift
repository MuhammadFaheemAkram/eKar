//
//  Enum.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

enum CarColors: String {
    case bisque = "Bisque"
    case darkGray = "Dark Gray"
    case mistryGray = "Misty Gray"
    case barcelonaRedMet = "Barcelona Red Met"
    case black = "Black"
    case blizzardPearl = "Blizzard Pearl"
    case blueRibbonMetallic = "Blue Ribbon Metallic"
    case classicSilverMetallic = "Classic Silver Metallic"
    case clearSkyMetallic = "Clear Sky Metallic"
    case magneticGrayMetallic = "Magnetic Gray Metallic"
    case seaGlassPearl = "Sea Glass Pearl"
    case white = "White"
    
    static func getColor(name: String) -> UIColor {
        let color = CarColors(rawValue: name)
        switch color {
        case .bisque:
            return UIColor(hexFromInt: 0xFFE4C4)
        case .darkGray:
            return UIColor(hexFromInt: 0x585958)
        case .mistryGray:
            return UIColor(hexFromInt: 0xBCC2C2)
        case .barcelonaRedMet:
            return UIColor(hexFromInt: 0xDB0030)
        case .black:
            return UIColor(hexFromInt: 0x000000)
        case .blizzardPearl:
            return UIColor(hexFromInt: 0xFAFBF5)
        case .blueRibbonMetallic:
            return UIColor(hexFromInt: 0x1C589E)
        case .classicSilverMetallic:
            return UIColor(hexFromInt: 0xAAA9AD)
        case .clearSkyMetallic:
            return UIColor(hexFromInt: 0xCED1CC)
        case .magneticGrayMetallic:
            return UIColor(hexFromInt: 0xB4B6B1)
        case .seaGlassPearl:
            return UIColor(hexFromInt: 0xD1E6E5)
        default:
            return UIColor(hexFromInt: 0xFFFFFF)
        }
    }
}
