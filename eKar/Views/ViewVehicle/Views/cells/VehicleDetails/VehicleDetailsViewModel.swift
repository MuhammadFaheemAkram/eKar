//
//  VehicleDetailsViewModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation
import UIKit

struct VehicleDetailsViewModel {
    
    //MARK: Properties
    let year: String
    let basePrice: Double
    let exteriorColors: [UIColor]
    
    //MARK: init Methods
    init(year: String, basePrice: String, colors: [String]) {
        let digitsOnly = basePrice.filter("0123456789".contains)
        let intValue = Int(digitsOnly) ?? 0
        let aed = 3.67 //conversion from $ to aed
        let totalPrice = aed * Double(intValue)
        
        self.basePrice = floor(totalPrice)
        self.exteriorColors = colors.map({ CarColors.getColor(name: $0) })
        self.year = "\(LocalizedKey.year.string) - \(year)"
    }

    
    //MARK: Public Methods
    func getBookingFeeText() -> NSMutableAttributedString {
        return Utils.getBookingFeeText(biggerString: "120",
                                       smallerString: LocalizedKey.aed.string)
    }
    
    func getPriceText() -> NSMutableAttributedString {
        let formattedValue = Utils.getFormattedPrice(price: basePrice)
        return Utils.getAttributedString(biggerString: formattedValue,
                                         smallerString: "\(LocalizedKey.aed.string) / \(LocalizedKey.month.string)")
    }
    
    /// Get text to show thw lenth of contract
    /// - Parameter value: selected value of slider
    /// - Returns: returns an attributes strings containg info about contract length
    func getContractLengthText(value: Int) -> NSMutableAttributedString {
        return Utils.getAttributedString(biggerString: "\(value)",
                                         smallerString: "\(LocalizedKey.months.string)")
    }
    
    
}

