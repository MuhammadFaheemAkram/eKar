//
//  ViewVehicleViewModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

typealias Alert = (title: String, message: String)

class ViewVehicleViewModel {
    
    //MARK: Properties
    private let vehicleId: String
    private var repository: VehicleRepository
    private(set) var vehicle: VehicleDetailModel?
    private(set) var vehicleImage: VehicleImageModel?
    
    var isLoading = Bindable<Bool>(false)
    var showAlert = Bindable<Alert>((kBlankString,kBlankString))
    var reloadData = Bindable<Bool>(false)
    var reloadBottomView = Bindable<Bool>(false)
    
    //MARK: Init Methods
    init(vehicleId: String, repository: VehicleRepository) {
        self.vehicleId = vehicleId
        self.repository = repository
    }
    
    
    //MARK: Helper Methods
    func getRowCount() -> Int {
        vehicle == nil ? 0 : 4
    }
    
    ///Creates a view model object for the vehicle details cell
    func getVehicleDetailsCellVM() -> VehicleDetailsViewModel? {
        guard let vehicle = vehicle else {
            return nil
        }
        ///Provides year, base price and color attributes
        let viewModel = VehicleDetailsViewModel(year: vehicle.attributes.year,
                                                        basePrice: vehicle.attributes.manufacturerSuggestedRetailPrice,
                                                        colors: vehicle.attributes.exteriorColor)
        return viewModel
    }
    
    ///Creates a view model object for more info of vehicle
    func getVehicleAboutCellVM() -> VehicleMoreInfoCellViewModel? {
        guard let vehicle = vehicle else {
            return nil
        }
        /// Provides engine info, number of deats avaialble, engine type and type of fuel
        let viewModel = VehicleMoreInfoCellViewModel(engine: vehicle.attributes.engine,
                                                  seats: vehicle.attributes.standardSeating,
                                                  carGear: vehicle.attributes.transmissionShort,
                                                  carFuel: vehicle.attributes.fuelType)
        return viewModel
    }
    
    /// This craetes a list of features from vehicle equipments info using the std value
    func getVehicleKeyFeatures() -> [String] {
        guard let vehicle = vehicle else {
            return []
        }
        let vehicleKeyFeatures = vehicle.equipment.filter({ $0.value == .std }).map({ value in
            let components = value.key.components(separatedBy: "_")
            var originalString = ""
            components.forEach { string in
                originalString.append(string.pascalCase)
                originalString.append(" ")
            }
            return originalString
        })
        
        return vehicleKeyFeatures
    }
    
}

//MARK: API Calls
extension ViewVehicleViewModel {
    
    ///get vehicle details from api
    func getVehicleDeatils() {
        if !Utils.checkInternetConnection() {
            showAlert.value = (ALERT_APP_TITLE, LocalizedKey.noInternet.string)
            return
        }
        isLoading.value = true
        repository.getVehicleDetails(with: vehicleId) { result in
            self.isLoading.value = false
            switch result {
            case .success(let vehicle):
                self.vehicle = vehicle
                self.reloadBottomView.value = true
                self.getVehicleImages()
            case .failure(let error):
                let message = error.message
                self.showAlert.value = (LocalizedKey.error.string, message)
            }
        }
    }
    
    ///get vehicle images list from api
    func getVehicleImages() {
        guard let vehicle = vehicle else { return }
        isLoading.value = true
        repository.getVehicleImage(make: vehicle.attributes.make,
                                   model: vehicle.attributes.model,
                                   year: vehicle.attributes.year) { result in
            self.isLoading.value = false
            switch result {
            case .success(let images):
                self.vehicleImage = images
                self.reloadData.value = false
            case .failure(let error):
                let message = error.message
                self.showAlert.value = (LocalizedKey.error.string, message)
            }
        }
    }
}
