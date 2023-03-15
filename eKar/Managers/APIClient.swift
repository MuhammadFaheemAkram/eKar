//
//  APIClient.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import Foundation
import Alamofire

protocol HTTPRequest {
	
	var endPoint: URL? { get }
	
	var method: HTTPMethod { get }
	
	var parameters: Parameters? { get }
	
	var headers: HTTPHeaders? { get }
	
}

extension HTTPRequest {
	
	var parameters: Parameters? { nil }
	
	var headers: HTTPHeaders? { nil }
}

typealias APIClientResult = Result<Any, EKarError>

class APIClient {
	
	
	// MARK: Class Instances
	
	static let shared = APIClient()
	
	
	// MARK: Initializers
	
	private init() {}
	
	// MARK: Public Methods
    
    /// This is general which is used to send request over network
    /// - Parameters:
    ///   - request: request object containg all request info
    ///   - shouldAddHeader: headers s requred on not
    ///   - completion: completion handler for response
	func performRequest(_ request: HTTPRequest,
                        shouldAddHeader : Bool = true,
                        andCompletion completion: @escaping (APIClientResult) -> Void) {
		
		guard let url = request.endPoint else {
			completion(.failure(EKarError(message: LocalizedKey.urlNotFound.string)))
			return
		}
		var headers: HTTPHeaders?
        if shouldAddHeader {
            headers = request.headers
        }
        print("Request Url ", url)
        print("Params ", request.parameters ?? Parameters())
		
		let parameterEncoding: ParameterEncoding = request.method == .get ? URLEncoding() : JSONEncoding()

		AF.request(
			url, method: request.method,
			parameters: request.parameters,
			encoding: parameterEncoding,
			headers: headers
		).responseJSON { response in
			
			
			let headers = response.response?.allHeaderFields ?? [:]
			switch response.result {
			case .success(let value):
				completion(.success((headers: headers, body: value)))
			case .failure(let error):
				switch error {
				case .sessionTaskFailed( _):
					completion(.failure(EKarError(message: LocalizedKey.noInternet.string)))
				default:
					completion(.failure(EKarError(message: error.errorDescription ??
														LocalizedKey.somethingWentWrong.string)))
				}
			
			}
		}
	}
}
