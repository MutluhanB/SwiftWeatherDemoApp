//
//  CityListInteractor.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 14/07/2023.
//

import Foundation
import WeatherService

protocol CityListInteractorProtocol {
    func getWeatherInformation(lat: String, lon: String) async -> Result<CityWeatherStatusModel, AppError>
}

class CityListInteractor: CityListInteractorProtocol {
    
    private var presenter: CityListPresenter?
    let weatherRepository = WeatherRepository()
    
    func getWeatherInformation(lat: String, lon: String) async -> Result<CityWeatherStatusModel, AppError> {
        let result = await weatherRepository.getWeather(lat: lat, lon: lon)
        switch result {
        case .success(let response):
            let model = generateModel(response)
            return .success(model)
        case .failure(let failure):
            return .failure(.general(message: "error"))
        }
    }
    
    private func generateModel(_ response: WeatherResponse) -> CityWeatherStatusModel {
        return CityWeatherStatusModel(cityName: response.name, tempatureKelvin: (response.main?.temp ?? 0.0) - 272.15)
    }
}
