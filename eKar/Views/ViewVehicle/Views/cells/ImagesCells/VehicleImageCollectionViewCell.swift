//
//  VehicleImageCollectionViewCell.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit
import SDWebImage

class VehicleImageCollectionViewCell: BaseCollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var vehicleImage: UIImageView!
    
    func setImage(url: String) {
        setImageWithUrl(imageView: vehicleImage, url: url)
    }

}
