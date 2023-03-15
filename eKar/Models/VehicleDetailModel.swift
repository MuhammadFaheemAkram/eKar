//
//  VehicleDetailModel.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation

struct VehicleDetailModel: Codable {
    let attributes: VehicleAttributes
    let colors: [VehicleColor]
    let equipment: [String: VehicleEquipment]
    let warranties: [VehicleWarranty]
    let timestamp: String
}

// MARK: - Attributes
struct VehicleAttributes: Codable {
    let year, make, model, trim: String
    let style, type, size, category: String
    let madeIn, madeInCity, doors, fuelType: String
    let fuelCapacity, cityMileage, highwayMileage, engine: String
    let engineSize, engineCylinders, transmission, transmissionShort: String
    let transmissionType, transmissionSpeeds, drivetrain, antiBrakeSystem: String
    let steeringType, curbWeight, grossVehicleWeightRating, overallHeight: String
    let overallLength, overallWidth, wheelbaseLength, standardSeating: String
    let invoicePrice, deliveryCharges, manufacturerSuggestedRetailPrice, productionSeqNumber: String
    let frontBrakeType, rearBrakeType, turningDiameter, frontSuspension: String
    let rearSuspension, frontSpringType, rearSpringType, tires: String
    let frontHeadroom, rearHeadroom, frontLegroom, rearLegroom: String
    let frontShoulderRoom, rearShoulderRoom, frontHipRoom, rearHipRoom: String
    let interiorTrim, exteriorColor: [String]
    let curbWeightManual, groundClearance, trackFront, trackRear: String
    let cargoLength, widthAtWheelwell, widthAtWall, depth: String
    let optionalSeating, passengerVolume, cargoVolume, standardTowing: String
    let maximumTowing, standardPayload, maximumPayload, maximumGvwr: String

    enum CodingKeys: String, CodingKey {
        case year, make, model, trim, style, type, size, category
        case madeIn = "made_in"
        case madeInCity = "made_in_city"
        case doors
        case fuelType = "fuel_type"
        case fuelCapacity = "fuel_capacity"
        case cityMileage = "city_mileage"
        case highwayMileage = "highway_mileage"
        case engine
        case engineSize = "engine_size"
        case engineCylinders = "engine_cylinders"
        case transmission
        case transmissionShort = "transmission_short"
        case transmissionType = "transmission_type"
        case transmissionSpeeds = "transmission_speeds"
        case drivetrain
        case antiBrakeSystem = "anti_brake_system"
        case steeringType = "steering_type"
        case curbWeight = "curb_weight"
        case grossVehicleWeightRating = "gross_vehicle_weight_rating"
        case overallHeight = "overall_height"
        case overallLength = "overall_length"
        case overallWidth = "overall_width"
        case wheelbaseLength = "wheelbase_length"
        case standardSeating = "standard_seating"
        case invoicePrice = "invoice_price"
        case deliveryCharges = "delivery_charges"
        case manufacturerSuggestedRetailPrice = "manufacturer_suggested_retail_price"
        case productionSeqNumber = "production_seq_number"
        case frontBrakeType = "front_brake_type"
        case rearBrakeType = "rear_brake_type"
        case turningDiameter = "turning_diameter"
        case frontSuspension = "front_suspension"
        case rearSuspension = "rear_suspension"
        case frontSpringType = "front_spring_type"
        case rearSpringType = "rear_spring_type"
        case tires
        case frontHeadroom = "front_headroom"
        case rearHeadroom = "rear_headroom"
        case frontLegroom = "front_legroom"
        case rearLegroom = "rear_legroom"
        case frontShoulderRoom = "front_shoulder_room"
        case rearShoulderRoom = "rear_shoulder_room"
        case frontHipRoom = "front_hip_room"
        case rearHipRoom = "rear_hip_room"
        case interiorTrim = "interior_trim"
        case exteriorColor = "exterior_color"
        case curbWeightManual = "curb_weight_manual"
        case groundClearance = "ground_clearance"
        case trackFront = "track_front"
        case trackRear = "track_rear"
        case cargoLength = "cargo_length"
        case widthAtWheelwell = "width_at_wheelwell"
        case widthAtWall = "width_at_wall"
        case depth
        case optionalSeating = "optional_seating"
        case passengerVolume = "passenger_volume"
        case cargoVolume = "cargo_volume"
        case standardTowing = "standard_towing"
        case maximumTowing = "maximum_towing"
        case standardPayload = "standard_payload"
        case maximumPayload = "maximum_payload"
        case maximumGvwr = "maximum_gvwr"
    }
}

// MARK: - Color
struct VehicleColor: Codable {
    let category: Category
    let name: String
}

enum Category: String, Codable {
    case exterior = "Exterior"
    case interior = "Interior"
}

enum VehicleEquipment: String, Codable {
    case nA = "N/A"
    case opt = "Opt."
    case std = "Std."
}


// MARK: - Warranty
struct VehicleWarranty: Codable {
    let type, miles, months: String
}

