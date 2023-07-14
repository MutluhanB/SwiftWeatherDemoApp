//
//  AddCityInteractor.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 06/07/2023.
//

import Foundation
import WeatherService

protocol AddCityInteractorProtocol {
    func searchForLocation(location: String, limit: String) async -> Result<[CitySummaryModel], AppError>
}

class AddCityInteractor: AddCityInteractorProtocol {
    
    private var presenter: AddCityPresenter?
    let geoRepository = GeoRepository()
    
    func searchForLocation(location: String, limit: String) async -> Result<[CitySummaryModel], AppError> {
        let result = await geoRepository.searchLocation(searchText: location, limit: limit)
        switch result {
        case .success(let response):
            let models = generateSearchResultModels(response: response)
            return .success(models)
        case .failure(let failure):
            return .failure(.general(message: "error occured..."))
        }
    }
    
    private func generateSearchResultModels(response: SearchLocationResponse) -> [CitySummaryModel] {
        return response.map({CitySummaryModel(name: $0.name, lat: $0.lat, lon: $0.lon, country: $0.country, state: $0.state)})
    }
}
