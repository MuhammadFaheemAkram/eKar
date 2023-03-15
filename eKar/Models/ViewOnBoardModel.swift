//
//  ViewOnBoardModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class ViewOnBoardModel{
    
    var label: String?
    var placeholderImage: UIImage?
    var selectedImage: UIImage?
    
    init(label: String, placeholderImage: UIImage?) {
        self.label = label
        self.placeholderImage = placeholderImage
    }
}
