//
//  WeatherResponse.swift
//  WeatherService
//
//  Created by mutluhan.boz on 08/07/2023.
//

import Foundation

public struct WeatherResponse: Codable {
    public var main: MainInformation?
    public var name: String?
}

public struct MainInformation: Codable {
    public var temp, feelsLike, tempMin, tempMax: Double?
    public var pressure, humidity, seaLevel, grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}
