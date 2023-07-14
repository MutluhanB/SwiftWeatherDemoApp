//
//  GeoEndpoints.swift
//  WeatherService
//
//  Created by mutluhan.boz on 05/07/2023.
//

import Foundation

enum GeoEndpoints {
    case searchLocation(searchText: String, limit: String)
}


extension GeoEndpoints: Endpoint {
    
    var path: String {
        switch self {
        case .searchLocation:
            return "/geo/1.0/direct"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .searchLocation:
            return .get
        }
    }
    
    var header: HTTPRequestHeader? {
        switch self {
        case .searchLocation:
            return nil
        }
    }
    
    var body: HTTPRequestBody? {
        switch self {
        case .searchLocation:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchLocation(let searchText, let limit):
            return [URLQueryItem(name: "q", value: searchText),
                    URLQueryItem(name: "limit", value: limit)]
        }
    }
    
}
