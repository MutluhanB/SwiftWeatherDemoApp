//
//  WeatherServiceError.swift
//  WeatherService
//
//  Created by mutluhan.boz on 04/07/2023.
//

import Foundation

public enum ServiceError: Error {
    case urlFormatting
    case missingResponse
    case unableToDecode
    case unauthorized
    case unhandledStatusCode
    case unexpectedError
}
