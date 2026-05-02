//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Combine
import SwiftUI

enum RecipeListState {
    case loading
    case success
    case error
}

@Observable
class RecipeListViewModel {
    let service: RecipesServiceProtocol
    init(service: RecipesServiceProtocol) {
        self.service = service
    }
    
    var viewState: RecipeListState = .loading
    var recipes: [Recipe] = []
    var categories: [CategoryDisplayModel] = []
    var selectedCategory: String = ""
    var title: String = "Mom's Recipes"
    
    func loadData() async {
        viewState = .loading
        do {
            categories = try await service.fetchRecipeCategories()
            selectedCategory = categories.first?.name ?? ""
            try await loadRecipes(for: selectedCategory)
            viewState = .success
        } catch {
            viewState = .error
        }
    }

    func selectCategory(category: String) async {
        guard category != selectedCategory else { return }
        selectedCategory = category
        do {
            try await loadRecipes(for: category)
        } catch {
            recipes = []
        }
    }
    
    private func loadRecipes(for category: String) async throws {
        recipes = try await service.fetchRecipes(category: category)
    }
}
