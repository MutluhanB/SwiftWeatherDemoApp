//
//  GeoRepository.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 06/07/2023.
//

import Foundation
import WeatherService

protocol GeoRepositoryProtocol {
    func searchLocation(searchText: String, limit: String) async -> Result<SearchLocationResponse, ServiceError>
}

class GeoRepository: GeoRepositoryProtocol {
    
    let service = GeoService()
    
    func searchLocation(searchText: String, limit: String) async -> Result<SearchLocationResponse, ServiceError> {
        return await service.searchLocation(searchText: searchText, limit: limit)
    }
}
