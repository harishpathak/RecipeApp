//
//  Category.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import Foundation

struct CategoryResponse: Decodable {
    let categories: [CategoryDTO]
}

struct CategoryDTO: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}


struct CategoryDisplayModel: Identifiable {
    let id: String           // Maps from idCategory
    let name: String         // Maps from strCategory
    let imageUrl: URL?       // Converted to a URL object
    let description: String  // Maps from strCategoryDescription
    
    // Custom initializer to map from the DTO
    init(from dto: CategoryDTO) {
        self.id = dto.idCategory
        self.name = dto.strCategory
        self.imageUrl = URL(string: dto.strCategoryThumb)
        self.description = dto.strCategoryDescription
    }
}

