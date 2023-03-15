//
//  ViewVehicle.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation
import Alamofire

typealias VehicleResult = Result<VehicleDetailModel,EKarError>
typealias VehicleImagesResult = Result<VehicleImageModel,EKarError>

class VehicleRepository {
    
    func getVehicleDetails(with id: String,
                           completion: @escaping (VehicleResult) -> Void ){
    
        APIClient.shared.performRequest(VehicleRequest.getVehicleDetails(id: id),
                                        shouldAddHeader: false, andCompletion: {
            result in
            switch result {
            case .success(let value):
                guard  let (_,body) = value as? (Any, Any) else {
                    completion(.failure(EKarError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                
                guard let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) else {
                    completion(.failure(EKarError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                
                guard let vehicle = try? JSONDecoder().decode(VehicleDetailModel.self, from: data) else {
                    completion(.failure(EKarError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                completion(.success(vehicle))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func getVehicleImage(make: String,
                         model: String,
                         year: String,
                         completion: @escaping (VehicleImagesResult) -> Void ){
    
        APIClient.shared.performRequest(VehicleRequest.getVehicleImage(make: make,
                                                                       model: model,
                                                                       year: year),
                                        shouldAddHeader: false, andCompletion: {
            result in
            switch result {
            case .success(let value):
                guard  let (_,body) = value as? (Any, Any) else {
                    completion(.failure(EKarError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                
                guard let data = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted) else {
                    completion(.failure(EKarError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                
                guard let vehicle = try? JSONDecoder().decode(VehicleImageModel.self, from: data) else {
                    completion(.failure(EKarError(message: LocalizedKey.failedToParseData.string)))
                    return
                }
                completion(.success(vehicle))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

enum VehicleRequest: HTTPRequest {
    case getVehicleDetails(id: String)
    case getVehicleImage(make: String, model: String, year: String)
}

extension VehicleRequest {
    
    var method: HTTPMethod {
        switch self {
        case .getVehicleDetails, .getVehicleImage:
            return .get
        }
    }
    
    var endPoint: URL? {
        switch self {
        case .getVehicleDetails:
            return Endpoint.vehicleSpecs
        case .getVehicleImage:
            return Endpoint.vehicleImages
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getVehicleDetails(let id):
            return ["vin": id, "key": Global.apiKey]
        case .getVehicleImage(let make,
                              let model,
                              let year):
            return ["key": Global.apiKey,
                    "make":make,
                    "model":model,
                    "year":year,
                    "transparent":"true",
                    "size":"Medium",
                    "photoType":"exterior",
                    "angle":"front"]
        }
    }
}

