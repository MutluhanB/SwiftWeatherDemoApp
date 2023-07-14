//
//  WeatherService.swift
//  WeatherService
//
//  Created by mutluhan.boz on 08/07/2023.
//

import Foundation

protocol WeatherServiceProtocol {
    func getWeatherData(lat: String, lon: String) async -> Result<WeatherResponse, ServiceError>
}

public struct WeatherDetailService: BaseService {
    public init() {}
    
    public func getWeatherData(lat: String, lon: String) async -> Result<WeatherResponse, ServiceError> {
        return await sendRequest(endpoint: WeatherEndpoints.getWeather(lat: lat, lon: lon), responseModel: WeatherResponse.self)
    }

}
