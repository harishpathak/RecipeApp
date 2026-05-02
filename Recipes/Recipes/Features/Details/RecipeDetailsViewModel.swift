//
//  RecipeDetailsViewModel.swift
//  Recipes
//
//  Created by Harish on 02/05/2026.
//

import Combine
import SwiftUI

enum RecipeDetailsViewState {
    case valid
    case loading
    case error
}

@Observable
class RecipeDetailsViewModel {
    private var service: RecipesServiceProtocol
    private var recipeId: String
    var viewState: RecipeDetailsViewState = .loading
    var recipe: RecipeDetails?
    
    init(service: RecipesServiceProtocol, id: String) {
        self.service = service
        self.recipeId = id
    }
    
    func loadData() async {
        viewState = .loading
        do {
            recipe = try await service.fetchRecipe(with: recipeId)
            viewState = .valid
        } catch {
            viewState = .error
        }
    }
}
