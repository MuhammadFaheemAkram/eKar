//
//  VehicleMoreInfoTableViewCell.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class VehicleMoreInfoTableViewCell: BaseTableViewCell {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var engineLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var manualLabel: UILabel!
    @IBOutlet weak var petrolTypeLabel: UILabel!
    
    
    //MARK: Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        views.forEach { view in
            view.layer.cornerRadius = 8
            view.backgroundColor = Colors.primaryColor
        }
    }
    
    //MARK: Public Function
    func configureCell(viewModel: VehicleMoreInfoCellViewModel) {
        engineLabel.text = viewModel.engine
        seatsLabel.text = viewModel.seats
        manualLabel.text = viewModel.carGear
        petrolTypeLabel.text = viewModel.carFuel
    }
}
