//
//  ViewVehicle.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

class ViewVehicle: BaseView {
    
    //MARK: Outlets
    @IBOutlet weak var vehicleImage: UIImageView!
    @IBOutlet weak var vehicleName: UILabel!
    @IBOutlet weak var vehicleBrand: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 190, right: 0)
        }
    }

}
