//
//  UploadVehicleImageCollectionViewCell.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class UploadVehicleImageCollectionViewCell: BaseCollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    
    //MARK: ConfigureCell
    func configureCell(viewOnBoardModel: ViewOnBoardModel) {
        vehicleImage.image = viewOnBoardModel.selectedImage == nil ? viewOnBoardModel.placeholderImage : viewOnBoardModel.selectedImage
        imageLabel.text = viewOnBoardModel.label
    }

}
