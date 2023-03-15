//
//  VehicleImageModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

struct VehicleImageModel: Codable {
    let images: [ImageModel]
}

// MARK: - Image
struct ImageModel: Codable {
    let mime: String
    let link: String
    let contextLink: String
    let height, width, byteSize: Int
    let thumbnailLink: String
    let thumbnailHeight, thumbnailWidth: Int
    let hostPageDomainFriendlyName, accentColor, datePublished: String
}
