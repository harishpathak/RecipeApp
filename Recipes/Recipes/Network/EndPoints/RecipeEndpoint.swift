//
//  RecipesEndpoint.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

enum RecipesEndpoints: EndpointProtocol {
    case categories
    case recipes(category: String)
    case recipe(id: String)
    
    var url: String {
        switch self {
        case .categories:
            "https://www.themealdb.com/api/json/v1/1/categories.php"
        case .recipes:
            "https://www.themealdb.com/api/json/v1/1/filter.php?"
        case .recipe:
            "https://www.themealdb.com/api/json/v1/1/lookup.php?"
        }
    }
    
    var requestType: RequestType {
        .get
    }
    
    var body: Data? {
        nil
    }
    
    var params: [String: String]? {
        switch self {
        case .categories:
            nil
        case .recipes(let category):
            ["c": category]
        case .recipe(let id):
            ["i" : id]
        }
    }
}
