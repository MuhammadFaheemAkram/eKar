//
//  LocalizedKey.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

enum LocalizedKey: String {
    
    var string: String {
        self.rawValue
    }
    
    case ok = "Ok"
    case yes = "Yes"
    case cancel = "Cancel"
    case urlNotFound = "Url not found"
    case somethingWentWrong = "Oops something went wrong"
    case noInternet = "No internet available"
    case failedToParseData = "Failed to pasrse json data"
    case camera = "Camera"
    case photos = "Photos"
    case error = "Error"
    case year = "Year"
    case aed = "AED"
    case month = "MONTH"
    case months = "MONTHS"
    case seats = "Seats"
    case petrol = "Petrol"
    case howContractWorks = "This is a dummy messege to show how contact will work"
    case frontLeft = "FRONT/LEFT"
    case frontRight = "FRONT/RIGHT"
    case backLeft = "BACK/LEFT"
    case backRight = "BACK/RIGHT"
    case openImageOptions = "Select a source to pick image"
    case uploadImagesError = "All images are requried please upload"
    case commentsError = "Enter your comments"
    case thankYouMessege = "Thank you for choosing ekar."
}
