//
//  RecipeRowView.swift
//  Recipes
//
//  Created by Harish on 10/06/2026.
//

import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    var body: some View {
        VStack {
            HStack {
                Text(recipe.name)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(10)
            Divider()
                .padding(.horizontal, 10)
        }
    }
}
