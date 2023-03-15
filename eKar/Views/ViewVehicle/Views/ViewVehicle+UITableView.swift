//
//  ViewVehicle+UITableView.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

//MARK: - UITableViewDelegate and UITableViewDataSource Methods
extension ViewVehicleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 180
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            return getVehicleImageTableViewCell(tableView, indexpath: indexPath)
        case 1:
            return getVehicleInfoCell(tableView, indexpath: indexPath)
        case 2:
            return getAboutVehicleCell(tableView, indexpath: indexPath)
        case 3:
            return getKeyFeatureCell(tableView, indexpath: indexPath)
        default:
            break
            
        }
        
        return UITableViewCell()
    }
    
    
    private func getAboutVehicleCell(_ tableView: UITableView, indexpath: IndexPath) -> UITableViewCell {

        guard let viewModel = viewModel.getVehicleAboutCellVM() else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: VehicleMoreInfoTableViewCell.reuseIdentifier, for: indexpath) as! VehicleMoreInfoTableViewCell

        cell.configureCell(viewModel: viewModel)
        return cell
    }

    private func getKeyFeatureCell(_ tableView: UITableView, indexpath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: KeyFeatureTableViewCell.reuseIdentifier, for: indexpath) as! KeyFeatureTableViewCell

        cell.reloadView = { [weak self] in
            self?.viewVehicle.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
        }

        cell.configureCell(keyFeatures: self.viewModel.getVehicleKeyFeatures())
        return cell
    }

    private func getVehicleInfoCell(_ tableView: UITableView, indexpath: IndexPath) -> UITableViewCell {

        guard let viewModel = viewModel.getVehicleDetailsCellVM() else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: VehichleDetailsTableViewCell.reuseIdentifier, for: indexpath) as! VehichleDetailsTableViewCell

        cell.delegate = self
        cell.configureCell(viewModel: viewModel)
        return cell
    }
    
    private func getVehicleImageTableViewCell(_ tableView: UITableView, indexpath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VehicleImageTableViewCell.reuseIdentifier, for: indexpath) as! VehicleImageTableViewCell
        
        cell.configureCell(images: viewModel.vehicleImage?.images ?? [])
        return cell
    }
    
    
}

