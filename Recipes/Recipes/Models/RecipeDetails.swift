//
//  RecipeDetails.swift
//  Recipes
//
//  Created by Harish on 02/05/2026.
//

import Foundation

struct RecipeDetailResponse: Decodable {
    let meals: [RecipeDetailDTO]
}

struct RecipeDetailDTO: Decodable {
    // Basic Info
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strYoutube: String
    
    // Ingredients (API provides these as individual numbered keys)
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    
    // Measures
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
}

struct RecipeDetails: Identifiable {
    let id: String
    let name: String
    let category: String
    let imageUrl: URL?
    let instructions: String?
    
    init(dto: RecipeDetailDTO) {
        id = dto.idMeal
        name = dto.strMeal
        category = dto.strCategory
        imageUrl = URL(string: dto.strMealThumb)
        instructions = dto.strInstructions
    }
}
