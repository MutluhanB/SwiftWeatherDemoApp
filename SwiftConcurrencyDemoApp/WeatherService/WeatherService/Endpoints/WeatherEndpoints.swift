//
//  WeatherEndpoints.swift
//  WeatherService
//
//  Created by mutluhan.boz on 08/07/2023.
//

import Foundation

enum WeatherEndpoints: Endpoint {
    case getWeather(lat: String, lon: String)
}

extension WeatherEndpoints {
    var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/weather"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var header: HTTPRequestHeader? {
        switch self {
        case .getWeather:
            return nil
        }
    }
    
    var body: HTTPRequestBody? {
        switch self {
        case .getWeather:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getWeather(let lat, let lon):
            return [URLQueryItem(name: "lat", value: lat),
                    URLQueryItem(name: "lon", value: lon)]
        }
    }
    
}
