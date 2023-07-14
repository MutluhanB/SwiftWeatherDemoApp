//
//  SearchLocationResponseElement.swift
//  WeatherService
//
//  Created by mutluhan.boz on 05/07/2023.
//

import Foundation

public struct SearchLocationResponseElement: Codable {
    public var name: String?
    public var country: String?
    public var state: String?
    public var lat: Double?
    public var lon: Double?
}

public typealias SearchLocationResponse = [SearchLocationResponseElement]
