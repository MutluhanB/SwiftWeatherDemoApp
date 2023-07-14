//
//  GeoService.swift
//  WeatherService
//
//  Created by mutluhan.boz on 05/07/2023.
//

import Foundation

protocol GeoServiceProtocol {
    func searchLocation(searchText: String, limit: String) async -> Result<SearchLocationResponse, ServiceError>
}

public struct GeoService: BaseService {
    public init() {}
    
    public func searchLocation(searchText: String, limit: String) async -> Result<SearchLocationResponse, ServiceError> {
        return await sendRequest(endpoint: GeoEndpoints.searchLocation(searchText: searchText, limit: limit), responseModel: SearchLocationResponse.self)
    }

}
