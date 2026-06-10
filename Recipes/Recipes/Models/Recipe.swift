//
//  Recipe.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

struct Recipe: Identifiable {
    let id: String
    let name: String
    var area: String? = nil
    var imageUrl: URL? = nil
}

extension Recipe {
    init(dto: RecipeDTO) {
        id = dto.idMeal
        name = dto.strMeal
        area = dto.strArea
        imageUrl = URL(string: dto.strMealThumb)
    }
}

struct RecipesDTO: Decodable {
    let meals: [RecipeDTO]
}

struct RecipeDTO: Decodable {
    let strMeal: String
    let strMealThumb: String
    let strArea: String?
    let strCountry: String?
    let idMeal: String
}
