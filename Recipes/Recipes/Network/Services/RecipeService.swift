//
//  RecipeService.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

protocol RecipesServiceProtocol {
    func fetchRecipes(category: String) async throws -> [Recipe]
    func fetchRecipeCategories() async throws -> [CategoryDisplayModel]
    func fetchRecipe(with id: String) async throws -> RecipeDetails
}

class RecipeService: RecipesServiceProtocol {
    var apiClient: APIClient
    var factory: RequestFactoryProtocol
    
    init(apiClient: APIClient = APIClient(session: URLSession.shared),
         factory: RequestFactoryProtocol = RequestFactory()) {
        self.apiClient = apiClient
        self.factory = factory
    }
    
    func fetchRecipes(category: String) async throws -> [Recipe] {
        let response: RecipesDTO = try await apiClient.fetch(request: factory.createRequest(from: RecipesEndpoints.recipes(category: category)))
        let displayModels = response.meals.map { dto in
            Recipe(dto: dto)
        }
        return displayModels
    }
    
    func fetchRecipeCategories() async throws -> [CategoryDisplayModel] {
        let response: CategoryResponse = try await apiClient.fetch(request: factory.createRequest(from: RecipesEndpoints.categories))
        let displayModels = response.categories.map { dto in
            CategoryDisplayModel(from: dto)
        }
        return displayModels
    }
    
    func fetchRecipe(with id: String) async throws -> RecipeDetails {
        let response: RecipeDetailResponse = try await apiClient.fetch(request: factory.createRequest(from: RecipesEndpoints.recipe(id: id)))
        guard let dto = response.meals.first else { throw APIError.noData }
        return RecipeDetails(dto: dto)
    }
}
