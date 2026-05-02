//
//  APIClient.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case badUrl
    case badResponse
    case apiError
    case decodingError
    case noData
}

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

class APIClient {
    private var session: URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func fetch<T: Decodable>(request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.badResponse
            }
            if httpResponse.statusCode == 200 {
                if let jsonString = String(data: data, encoding: .utf8),
                   let cleanData = jsonString.data(using: .utf8) {
                    let result = try JSONDecoder().decode(T.self, from: cleanData)
                    return result
                } else {
                    throw APIError.decodingError
                }
            } else {
                throw APIError.apiError
            }
        }
    }
   
}
