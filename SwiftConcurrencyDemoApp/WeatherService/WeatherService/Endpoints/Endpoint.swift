//
//  Endpoint.swift
//  WeatherService
//
//  Created by mutluhan.boz on 04/07/2023.
//

import Foundation

typealias HTTPRequestHeader = [String: String]
typealias HTTPRequestBody = [String: String]

protocol Endpoint {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var header: HTTPRequestHeader? { get }
    var body: HTTPRequestBody? { get }
}

extension Endpoint {
    var schema: String {
        return ServiceConstants.baseSchema
    }
    
    var host: String {
        return ServiceConstants.baseUrl
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
