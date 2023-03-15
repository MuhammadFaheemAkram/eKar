//
//  VehicleMoreInfoCellViewModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation


struct VehicleMoreInfoCellViewModel {
    
    //MARK: Properties
    var engine: String
    var seats: String
    var carGear: String
    var carFuel: String
    
    //MARK: init methods
    init(engine: String, seats: String, carGear: String, carFuel: String) {
        let components = engine.components(separatedBy: " ")
        self.engine = components.first ?? ""
        self.seats = seats + " \(LocalizedKey.seats.string)"
        self.carGear = carGear
        self.carFuel = carFuel.isEmpty ? LocalizedKey.petrol.string : carFuel
    }
}
