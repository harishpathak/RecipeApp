//
//  Endpoint.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

protocol EndpointProtocol {
    var url: String { get }
    var requestType: RequestType { get }
    var body: Data? { get }
    var params: [String: String]? { get }
}

struct EndPoint: EndpointProtocol {
    var requestType: RequestType
    var body: Data?
    var url: String
    var params: [String: String]?
}
