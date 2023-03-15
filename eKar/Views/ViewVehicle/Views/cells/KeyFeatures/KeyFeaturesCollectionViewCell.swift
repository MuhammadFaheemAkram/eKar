//
//  KeyFeaturesCollectionViewCell.swift
//  ekar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class KeyFeaturesCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var featureLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    
    //MARK: Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        outerView.backgroundColor = Colors.primaryColor
        outerView.layer.cornerRadius = 8
    }

}
