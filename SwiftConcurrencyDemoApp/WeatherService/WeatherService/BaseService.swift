//
//  BaseService.swift
//  WeatherService
//
//  Created by mutluhan.boz on 04/07/2023.
//

import Foundation

protocol BaseService {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, ServiceError>
}

extension BaseService {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type) async -> Result<T, ServiceError> {
            var urlComponents = URLComponents()
            urlComponents.scheme = endpoint.schema
            urlComponents.host = endpoint.host
            urlComponents.path = endpoint.path
            
            let appIdQueryItem = URLQueryItem(name: ServiceConstants.kApiKeyQueryItemName, value: ServiceConstants.apiKey)
            var requestQueryItems = endpoint.queryItems ?? []
            requestQueryItems.append(appIdQueryItem)
            urlComponents.queryItems = requestQueryItems
        
            guard let url = urlComponents.url else {
                return .failure(.urlFormatting)
            }
           
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.header
            
            if let body = endpoint.body {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let response = response as? HTTPURLResponse else {
                    return .failure(.missingResponse)
                }
                
                switch response.statusCode {
                case 200...299:
                    guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                        return .failure(.unableToDecode)
                    }
                    
                    return .success(decodedResponse)
                case 401:
                    return .failure(.unauthorized)
                default:
                    return .failure(.unhandledStatusCode)
                    
                }
            } catch {
                return .failure(.unexpectedError)
            }
        }

}
