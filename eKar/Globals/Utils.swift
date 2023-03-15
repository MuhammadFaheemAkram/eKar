//
//  Utils.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class Utils {
    
    static func checkInternetConnection() -> Bool {
        return BReachability.isConnectedToNetwork()
    }
    
    static func getAttributedString(biggerString: String, smallerString: String) -> NSMutableAttributedString {
        let fullString = biggerString + " " + smallerString
        let attributedString = NSMutableAttributedString(string: fullString)
        let boldFont = UIFont.boldSystemFont(ofSize: 30)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (fullString as NSString).range(of: biggerString)
        attributedString.addAttributes(attributes, range: range)
        
        // Set regular font for remaining words
        let regularFont = UIFont.systemFont(ofSize: 10)
        let remainingRange = NSRange(location: range.upperBound, length: fullString.count - range.upperBound)
        let remainingAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: regularFont]
        attributedString.addAttributes(remainingAttributes, range: remainingRange)
        return attributedString
    }
    
    static func getBookingFeeText(biggerString: String, smallerString: String) -> NSMutableAttributedString {
        let fullString = "AED 120"
        
        let attributedString = NSMutableAttributedString(string: fullString)
        let boldFont = UIFont.systemFont(ofSize: 10)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (fullString as NSString).range(of: fullString.components(separatedBy: " ")[0])
        attributedString.addAttributes(attributes, range: range)
        
        // Set regular font for remaining words
        let regularFont = UIFont.boldSystemFont(ofSize: 30)
        let remainingRange = NSRange(location: range.upperBound, length: fullString.count - range.upperBound)
        let remainingAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: regularFont]
        attributedString.addAttributes(remainingAttributes, range: remainingRange)
        return attributedString
    }
    
    static func getAttributedTextFor(make: String, model: String) -> NSMutableAttributedString {
        let fullString = "\(make) \(model)"
        let attributedString = NSMutableAttributedString(string: fullString)

        // Set bold font for first word
        let boldFont = UIFont.boldSystemFont(ofSize: 20)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (fullString as NSString).range(of: fullString.components(separatedBy: " ")[0])
        attributedString.addAttributes(attributes, range: range)
        
        // Set regular font for remaining words
        let regularFont = UIFont.systemFont(ofSize: 16)
        let remainingRange = NSRange(location: range.upperBound, length: fullString.count - range.upperBound)
        let remainingAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: regularFont]
        attributedString.addAttributes(remainingAttributes, range: remainingRange)
        return attributedString
    }
    
    static func getFormattedPrice(price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedString = formatter.string(from: NSNumber(value: price)) ?? ""
        return formattedString
    }
    
}
