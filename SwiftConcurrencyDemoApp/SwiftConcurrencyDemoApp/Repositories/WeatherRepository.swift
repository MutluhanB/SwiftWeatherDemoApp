//
//  WeatherRepository.swift
//  SwiftConcurrencyDemoApp
//
//  Created by mutluhan.boz on 08/07/2023.
//

import Foundation
import WeatherService

protocol WeatherRepositoryProtocol {
    func getWeather(lat: String, lon: String) async -> Result<WeatherResponse, ServiceError>
}

class WeatherRepository: WeatherRepositoryProtocol {
    let service = WeatherDetailService()
    
    func getWeather(lat: String, lon: String) async -> Result<WeatherResponse, ServiceError> {
        return await service.getWeatherData(lat: lat, lon: lon)
    }

}
