//
//  RequestFactory.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

protocol RequestFactoryProtocol {
    func createRequest(from endPoint: EndpointProtocol) throws -> URLRequest
}

class RequestFactory: RequestFactoryProtocol {
    func createRequest(from endPoint: EndpointProtocol) throws -> URLRequest {
        guard var components = URLComponents(string: endPoint.url) else {
            throw APIError.badUrl
        }

        if let params = endPoint.params {
            components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value)}
        }
        
        guard let url = components.url else {
            throw APIError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.requestType.rawValue
        
        if endPoint.requestType == .post {
            request.httpBody = endPoint.body
        }
        
        return request
    }
}
