//
//  RecipesApp.swift
//  Recipes
//
//  Created by Harish on 01/05/2026.
//

import SwiftUI

@main
struct RecipesApp: App {
    private let service = RecipeService()
    var body: some Scene {
        WindowGroup {
            RecipeListView(service: service)
        }
    }
}

